defmodule TriadsExtractor do
  @moduledoc """
  Documentation for `TriadsExtractor`.
  """

  def run(input, output) do
    output_file = File.stream!(output || "out.txt")

    File.stream!(input || "in.csv")
    |> CSV.decode(headers: true, separator: ?\t)
    |> Stream.map(fn {:ok, row} -> row["tweet"] end)
    |> Stream.map(fn str -> cleanup(str) end)
    |> Stream.filter(fn str -> String.length(str) >= 3 end)
    |> Stream.dedup()
    |> Stream.with_index(1)
    |> Stream.each(fn {str, idx} ->
      IO.puts("#{idx} | #{str}")
    end)
    |> Stream.map(fn {str, _} -> str end)
    |> Stream.intersperse("\n")
    |> Stream.into(output_file)
    |> Stream.run()
  end

  def cleanup(str) do
    # Sara : 1 char max.
    str = Regex.replace(~r/([ฯ-๛])\1{1,}/u, str, "\\1")
    # Other : 2 chars max.
    str = Regex.replace(~r/(\w)\1{2,}/u, str, "\\1\\1")

    Regex.scan(~r/[ก-๛ ]+/u, str)
    |> Enum.map(fn arr ->
      Enum.join(arr)
      |> String.trim()
    end)
    |> Enum.filter(fn str -> String.length(str) >= 3 end)
    |> Enum.join(" ")
  end

  @doc """
  Tallys multiple string separated by space to triads map with frequencies

  ## Examples

      iex> TriadsExtractor.line_to_triads("abcd bcde")
      %{ "abc" => 1, "bcd" => 2, "cde" => 1 }

  """
  def line_to_triads(str) do
    str
    |> String.split()
    |> Enum.map(&to_triads(&1))
    |> Enum.reduce(%{}, fn x, acc -> Map.merge(x, acc, fn _k, a, b -> a + b end) end)
  end

  @doc """
  Tallys string to triads map with frequencies

  ## Examples

      iex> TriadsExtractor.to_triads("abcd")
      %{ "abc" => 1, "bcd" => 1 }

  """
  def to_triads(str) do
    str
    |> String.codepoints()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.join(&1))
    |> Enum.frequencies()
  end
end

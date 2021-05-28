defmodule TriadsExtractor do
  use Application

  @moduledoc """
  Documentation for `TriadsExtractor`.
  """


  def start(_type, _args) do
    IO.puts "starting"
    run()
    # some more stuff

    # Exit gracefully
    Supervisor.start_link [], strategy: :one_for_one
  end

  @doc """
  Hello world.

  ## Examples

      iex> TriadsExtractor.hello()
      :world

  """
  def run do
    System.argv()
       |> IO.inspect()
    output_file = File.stream!("out.txt")

    File.stream!("in.csv")
    |> CSV.decode(headers: true, separator: ?\t)
    |> Stream.map(fn({:ok, row}) -> row["tweet"] end)
    |> Stream.map(fn(str) -> cleanup(str) end)
    |> Stream.filter(fn str -> String.length(str) >= 3 end)
    |> Stream.dedup
    |> Stream.with_index(1)
    |> Stream.each(fn({str, idx}) ->
      IO.puts("#{idx} | #{str}")
    end)
    |> Stream.map(fn({str, _}) -> str end)
    |> Stream.intersperse("\n")
    |> Stream.into(output_file)
    |> Stream.run
  end

  def cleanup(str) do
    str = Regex.replace(~r/([ฯ-๛])\1{1,}/u, str, "\\1") # Sara : 1 char max.
    str = Regex.replace(~r/(\w)\1{2,}/u, str, "\\1\\1") # Other : 2 chars max.

    Regex.scan(~r/[ก-๛ ]+/u, str)
    |> Enum.map(fn arr ->
      Enum.join(arr)
      |> String.trim()
    end)
    |> Enum.filter(fn str -> String.length(str) >= 3 end)
    |> Enum.join(" ")
  end
end

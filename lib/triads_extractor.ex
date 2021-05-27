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
    output_file = File.stream!("out.txt")

    File.stream!("in.csv")
    |> CSV.decode(headers: true, separator: ?\t)
    |> Stream.map(fn({:ok, row}) -> extract_thai_tweet(row) <> "\n" end)
    |> Stream.filter(fn str -> String.length(str) >= 3 end)
    |> Enum.into(output_file)
  end

  def extract_thai_tweet(row) do
    Regex.scan(~r/[ก-๛]/u, row["tweet"]) |> Enum.join
  end
end

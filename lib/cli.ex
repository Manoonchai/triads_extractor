defmodule TriadsExtractor.CLI do
  def main(args) do
    options = [switches: [in: :string, out: :string], aliases: [i: :in, o: :out]]
    {opts, _, _} = OptionParser.parse(args, options)

    TriadsExtractor.run(opts[:in], opts[:out])
  end
end

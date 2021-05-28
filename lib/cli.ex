defmodule TriadsExtractor.CLI do
  def main(args) do
    options = [switches: [in: :string, out: :string, trim: :boolean], aliases: [i: :in, o: :out, t: :trim]]
    {opts, _, _} = OptionParser.parse(args, options)

    TriadsExtractor.run(opts[:in], opts[:out], opts[:trim])
  end
end

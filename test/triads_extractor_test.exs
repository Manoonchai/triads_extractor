defmodule TriadsExtractorTest do
  use ExUnit.Case
  doctest TriadsExtractor

  test "to_triads" do
    assert TriadsExtractor.to_triads("abc") == %{"abc" => 1}
    assert TriadsExtractor.to_triads("abcabc") == %{"abc" => 2, "bca" => 1, "cab" => 1}
    assert TriadsExtractor.to_triads("ab") == %{}
  end

  test "line_to_triads" do
    assert TriadsExtractor.line_to_triads("abc abc") == %{"abc" => 2}
    assert TriadsExtractor.line_to_triads("abcabc") == %{"abc" => 2, "bca" => 1, "cab" => 1}
    assert TriadsExtractor.line_to_triads("ab ab") == %{}

    assert TriadsExtractor.line_to_triads("ที่ทิ้ง") == %{
             "ที่" => 1,
             "ี่ท" => 1,
             "่ทิ" => 1,
             "ทิ้" => 1,
             "ิ้ง" => 1
           }
  end
end

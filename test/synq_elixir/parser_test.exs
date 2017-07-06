defmodule SynqElixirParserTest do
  use ExUnit.Case
  alias SynqElixir.Parser
  doctest SynqElixir

  @doc """
  Example of response for AWS Post
    {:ok,
   %HTTPoison.Response{body: "",
     headers: [{"x-amz-id-2",
      "amz"},
     {"x-amz-request-id", "122E97DAFA36213A"},
     {"Date", "Tue, 14 Feb 2017 22:38:46 GMT"},
     {"ETag", "\"123\""},
     {"Location",
      "https://synqfm.s3.amazonaws.com/projects%2F0a%2Fbf%2F0abfe1b849154082993f2fce77a16fd9%2Fuploads%2Fvideos%2Fac%2F87%2Fac87daf508194bed884e0eb732715510.mp4"},
     {"Server", "AmazonS3"}], status_code: 204}}
  """
  test "should handle 204 response" do
    resp = {:ok, %HTTPoison.Response{body: "", headers: [], status_code: 204}}
    assert {:ok, %{}} === Parser.parse(resp)
  end

  test "should handle AWS response" do
    headers = [{"x-amz-id-2", "amz"},
               {"x-amz-request-id", "122E97DAFA36213A"},
               {"Date", "Tue, 14 Feb 2017 22:38:46 GMT"},
               {"ETag", "\"123\""},
               {"Location", "https://synqfm.s3.amazonaws.com/projects%2F0a%2Fbf%2F0abfe1b849154082993f2fce77a16fd9%2Fuploads%2Fvideos%2Fac%2F87%2Fac87daf508194bed884e0eb732715510.mp4"},
               {"Server", "AmazonS3"}
              ]
    resp = {:ok, %HTTPoison.Response{body: "", headers: headers, status_code: 204}}
    assert {:ok, Enum.into(headers, %{})} === Parser.parse(resp)
  end
end

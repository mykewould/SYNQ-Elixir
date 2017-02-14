defmodule SynqElixir.Api do
  @moduledoc """
  API interface to communicate with Synq.fm API
  """

  use HTTPoison.Base
  alias SynqElixir.Parser
  alias SynqElixir.Resources.{Video}
  alias __MODULE__

  @user_agent [{"User-agent", "SynqElixir"}]
  @content_type [{"Content-Type", "application/x-www-form-urlencoded"}]

  @doc """
  Creating URL based on url from config and resources paths
  """
  @spec process_url(String.t) :: String.t
  def process_url(path) do
    "#{url}#{path}"
  end

  @doc """
  Create a video
  """
  @spec create(map) :: SynqElixir.Resources.Video
  def create(metadata) when map_size(metadata) > 0 do
    data = %{"userdata" => Poison.encode!(metadata)}
    synq_post(:create, data)
  end
  def create(_), do: synq_post(:create, %{})

  @doc """
  Get details about a video
  """
  @spec details(bitstring) :: SynqElixir.Resources.Video
  def details(video_id) do
    data = %{"video_id" => video_id}
    synq_post(:details, data)
  end

  @doc """
  Convenience call that will get the env variable, convert the map to a body
  set the headers and parse the output
  """
  @spec synq_post(bitstring, map) :: SynqElixir.Resources.Video
  def synq_post(action, data_map) do
    key = System.get_env("SYNQ_API_KEY")
    body = data_map
     |> Map.put_new("api_key", key)
     |> URI.encode_query
    action
     |> build_url
     |> Api.post(body, request_headers)
     |> Parser.parse(Video)
  end

  @doc """
  The upload is a two parter, first you have to call the "upload" and then you post the data

  {
    "action": "https://synqfm.s3.amazonaws.com/",
    "AWSAccessKeyId": "AKIAIP77Y7MMX3ITZMFA",
    "Content-Type": "video/mp4",
    "Policy": "eyJleHBpcmF0aW9uIiA6ICIyMDE2LTA0LTIyVDE5OjAyOjI2LjE3MloiLCAiY29uZGl0aW9ucyIgOiBbeyJidWNrZXQiIDogInN5bnFmbSJ9LCB7ImFjbCIgOiAicHVibGljLXJlYWQifSwgWyJzdGFydHMtd2l0aCIsICIka2V5IiwgInByb2plY3RzLzZlLzYzLzZlNjNiNzUyYTE4NTRkZGU4ODViNWNjNDcyZWRmNTY5L3VwbG9hZHMvdmlkZW9zLzJkLzgxLzJkODFjMzBjZTYyZjRkZmRiNTAxZGJjYTk2YzdhZTU2Lm1wNCJdLCBbInN0YXJ0cy13aXRoIiwgIiRDb250ZW50LVR5cGUiLCAidmlkZW8vbXA0Il0sIFsiY29udGVudC1sZW5ndGgtcmFuZ2UiLCAwLCAxMDk5NTExNjI3Nzc2XV19",
    "Signature": "ysqDemlKXKr6hKzVFP0hCGgf/cs=",
    "acl": "public-read",
    "key": "projects/6e/63/6e63b752a1854dde885b5cc472edf569/uploads/videos/2d/81/2d81c30ce62f4dfdb501dbca96c7ae56.mp4"
  }

  curl -s https://synqfm.s3.amazonaws.com/ \
    -F AWSAccessKeyId="AKIAIP77Y7MMX3ITZMFA" \
    -F Content-Type="video/mp4" \
    -F Policy="eyJleHBpcmF0aW9uIiA6ICIyMDE2LTA0LTIyVDE5OjAyOjI2LjE3MloiLCAiY29uZGl0aW9ucyIgOiBbeyJidWNrZXQiIDogInN5bnFmbSJ9LCB7ImFjbCIgOiAicHVibGljLXJlYWQifSwgWyJzdGFydHMtd2l0aCIsICIka2V5IiwgInByb2plY3RzLzZlLzYzLzZlNjNiNzUyYTE4NTRkZGU4ODViNWNjNDcyZWRmNTY5L3VwbG9hZHMvdmlkZW9zLzJkLzgxLzJkODFjMzBjZTYyZjRkZmRiNTAxZGJjYTk2YzdhZTU2Lm1wNCJdLCBbInN0YXJ0cy13aXRoIiwgIiRDb250ZW50LVR5cGUiLCAidmlkZW8vbXA0Il0sIFsiY29udGVudC1sZW5ndGgtcmFuZ2UiLCAwLCAxMDk5NTExNjI3Nzc2XV19" \
    -F Signature="ysqDemlKXKr6hKzVFP0hCGgf/cs=" \
    -F acl="public-read" \
    -F key="projects/6e/63/6e63b752a1854dde885b5cc472edf569/uploads/videos/2d/81/2d81c30ce62f4dfdb501dbca96c7ae56.mp4" \
    -F file="@my_video_file.mp4"
  """
  @spec upload(bitstring, bitstring) :: SynqElixir.response
  def upload(_video_id, _file) do
  end

  @doc """
  Builds URL based on the resource, id and parameters
  """
  @spec build_url(bitstring) :: String.t
  def build_url(action) do
    "/v1/video/#{action}"
  end

  def url, do: url(System.get_env("SYNQ_ENV") || :prod)
  def url(:stage), do: "https://api-staging.synq.fm"
  def url(:prod), do: "https://api.synq.fm"
  def url(env) when not is_nil(env) and is_bitstring(env), do: url(String.to_atom(env))
  def url(_), do: url(:prod)

  def request_headers, do: @content_type ++ @user_agent

end

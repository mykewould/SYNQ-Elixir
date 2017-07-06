[![CircleCI](https://circleci.com/gh/SYNQfm/SYNQ-Elixir.svg?style=svg)](https://circleci.com/gh/SYNQfm/SYNQ-Elixir)
[![Hex.pm](https://img.shields.io/badge/hex-0.0.1-orange.svg)](https://hex.pm/packages/synq_elixir)

# Elixir SDK for Synq API

Welcome to the Elixir SDK for the [Synq API](docs.synq.fm).  This is an implementation of the API [specification](https://docs.synq.fm/api/#!/video/create).  You can view the Elixir API reference [here](https://hexdocs.pm/synq_elixir/api-reference.html)

## Installation

SYNQ requires an API key for HTTP requests. Set the following env variable:
```
  SYNQ_API_KEY:your_api_key
```


Add SynqElixir to your list of dependencies in `mix.exs`:
```elixir
  def deps do
    [{:synq_elixir, github: "SYNQfm/SYNQ-Elixir"}]
  end
```
Or from hex:
```elixir
  def deps do
    [{:synq_elixir, "~> 0.0.1"}]
  end
```
Ensure you list `synq_elixir` in application dependency in your mix.exs file.
```elixir
  [applications: [:synq_elixir]]
```
### Examples

```elixir
# Create video
{:ok, video} = SynqElixir.Api.create()

# Create video with video file
{:ok, {video, upload_headers}} = SynqElixir.Api.create("~/Downloads/myvideo.mp4")

# Create video with custom metadata
{:ok, video} = SynqElixir.Api.create(%{foo: "bar"})

# Create video with video file and metadata
{:ok, {video, upload_headers}} = SynqElixir.Api.create("~/Downloads/myvideo.mp4", %{foo: "bar"})

# Get video details for video 'video123'
{:ok, video} = SynqElixir.Api.details("video123")

# upload video file to the video object 'video123'
{:ok, upload_headers} = SynqElixir.Api.upload("video123", "~/Downloads/myvideo.mp4")
```

Video object looks like this

```elixir
%SynqElixir.Resources.Video{
  created_at: "2017-02-15T03:01:16.767Z",
  updated_at: "2017-02-15T03:06:31.794Z",
  userdata: %{},
  player: %{
    "embed_url" => "https://player.synq.fm/embed/video123",
    "thumbnail_url" => "https://multicdn.synq.fm/projects/0a/bf/0abfe1b849154082993f2fce77a16fd9/derivatives/thumbnails/45/d4/video123/0000360.jpg",
    "views" => 0},
  state: "uploaded",
  video_id: "video123",
  outputs: %{
    "hls" => %{
      "state" => "complete", "url" => "https://multicdn.synq.fm/projects/0a/bf/0abfe1b849154082993f2fce77a16fd9/derivatives/videos/45/d4/video123/hls/video123_hls.m3u8"},
    "mp4_1080" => %{
      "state" => "complete", "url" => "https://multicdn.synq.fm/projects/0a/bf/0abfe1b849154082993f2fce77a16fd9/derivatives/videos/45/d4/video123/mp4_1080/video123_mp4_1080.mp4"},
    "mp4_360" => %{
      "state" => "complete", "url" => "https://multicdn.synq.fm/projects/0a/bf/0abfe1b849154082993f2fce77a16fd9/derivatives/videos/45/d4/video123/mp4_360/video123_mp4_360.mp4"},
    "mp4_720" => %{
      "state" => "complete", "url" => "https://multicdn.synq.fm/projects/0a/bf/0abfe1b849154082993f2fce77a16fd9/derivatives/videos/45/d4/video123/mp4_720/video123_mp4_720.mp4"},
    "webm_720" => %{
      "state" => "complete", "url" => "https://multicdn.synq.fm/projects/0a/bf/0abfe1b849154082993f2fce77a16fd9/derivatives/videos/45/d4/video123/webm_720/video123_webm_720.webm"}}
  }
```

Upload Headers look like this

```elixir
%{"x-amz-id-2" => "amz",
  "x-amz-request-id" => "122E97DAFA36213A",
  "Date" => "Tue, 14 Feb 2017 22:38:46 GMT",
  "ETag" => "\"123\"",
  "Location" => "https://synqfm.s3.amazonaws.com/projects%2F0a%2Fbf%2F0abfe1b849154082993f2fce77a16fd9%2Fuploads%2Fvideos%2Fac%2F87%video123.mp4",
  "Server" => "AmazonS3"
}
```

## Usage

You can use the functions in `SynqElixir.Api` for making requests to RESTful api of Synq.fm. There are shorthand functions that wrap the common get requests

You can also run convenience tasks that will help you testing creating of videos

```
# create and upload video
mix synq_task -c create -f ~/Downloads/myvideo.mp4

# create a video object
mix synq_task -c create

# get details for video 123
mix synq_task -c details -v 123

# upload file to video object
mix synq_task -c upload -v 123 -f ~/Downloads/myvideo.mp4
```

### Overriding Environment

By default, we'll use the `prod` environment. You can override the default environment by exporting the environment variable `SYNQ_ENV` which can be set `stage` or `prod`

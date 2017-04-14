defmodule SynqElixir.Resources.Video do
  @moduledoc """
  A video resource, am example metadata dump
  ```json
  {
    "video_id": "video123",
    "input": {
        "url": "https://multicdn.synq.fm/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/uploads/videos/4e/06/video123.mp4",
        "width": 1920,
        "height": 1080,
        "duration": "15.926000",
        "file_size": 34404630,
        "framerate": 29.51,
        "uploaded_at": "2016-10-09T15:36:54.624-04:00"
    },
    "state": "uploaded",
    "player": {
        "views": 0,
        "embed_url": "https://player.synq.fm/embed/video123"
        "thumbnail_url": "https://multicdn.synq.fm/projects/0a/bf/0abfe1b849154082993f2fce77a16fd9/derivatives/thumbnails/4e/06/video123.jpg"
    },
    "outputs": {
        "hls": {
            "url": "https://multicdn.synq.fm/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/derivatives/videos/4e/06/video123/hls/video123_hls.m3u8",
            "state": "complete"
        },
        "mp4_360": {
            "url": "https://multicdn.synq.fm/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/derivatives/videos/4e/06/video123/mp4_360/video123_mp4_360.mp4",
            "state": "complete"
        },
        "mp4_720": {
            "url": "https://multicdn.synq.fm/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/derivatives/videos/4e/06/video123/mp4_720/video123_mp4_720.mp4",
            "state": "complete"
        },
        "mp4_1080": {
            "url": "https://multicdn.synq.fm/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/derivatives/videos/4e/06/video123/mp4_1080/video123_mp4_1080.mp4",
            "state": "complete"
        },
        "webm_720": {
            "state": "progressing"
        }
    },
    "userdata": {
        "foo": "bar"
    },
    "created_at": "2016-08-01T15:41:51.555Z",
    "updated_at": "2016-10-09T19:37:10.281Z"
  }
  ```
  """

  @derive [Poison.Encoder]
  defstruct video_id: nil,
            outputs: [],
            userdata: %{},
            state: nil,
            player: %{},
            created_at: nil,
            updated_at: nil
end

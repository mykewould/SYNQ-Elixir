defmodule SynqElixir.Resources.Video do
  @moduledoc """
  A video resource, am example metadata dump

  {
    "video_id": "4e063ab632f24992aced5c6f8983229f",
    "input": {
        "url": "https://dcuu5ylopkzzf.cloudfront.net/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/uploads/videos/4e/06/4e063ab632f24992aced5c6f8983229f.mp4",
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
        "embed_url": "https://player.synq.fm/embed/4e063ab632f24992aced5c6f8983229f"
    },
    "outputs": {
        "hls": {
            "url": "https://dcuu5ylopkzzf.cloudfront.net/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/derivatives/videos/4e/06/4e063ab632f24992aced5c6f8983229f/hls/4e063ab632f24992aced5c6f8983229f_hls.m3u8",
            "state": "complete"
        },
        "mp4_360": {
            "url": "https://dcuu5ylopkzzf.cloudfront.net/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/derivatives/videos/4e/06/4e063ab632f24992aced5c6f8983229f/mp4_360/4e063ab632f24992aced5c6f8983229f_mp4_360.mp4",
            "state": "complete"
        },
        "mp4_720": {
            "url": "https://dcuu5ylopkzzf.cloudfront.net/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/derivatives/videos/4e/06/4e063ab632f24992aced5c6f8983229f/mp4_720/4e063ab632f24992aced5c6f8983229f_mp4_720.mp4",
            "state": "complete"
        },
        "mp4_1080": {
            "url": "https://dcuu5ylopkzzf.cloudfront.net/projects/1c/d7/1cd7494b9e8741e2852055e98486bc46/derivatives/videos/4e/06/4e063ab632f24992aced5c6f8983229f/mp4_1080/4e063ab632f24992aced5c6f8983229f_mp4_1080.mp4",
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

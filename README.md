[![CircleCI](https://circleci.com/gh/SYNQfm/SYNQ-Elixir.svg?style=svg)](https://circleci.com/gh/SYNQfm/SYNQ-Elixir)
[![Hex.pm](https://img.shields.io/badge/hex-0.0.1-orange.svg)](https://hex.pm/packages/synq_elixir)

# Elixir SDK for Synq API

Welcome to the Elixir SDK for the [Synq API](docs.synq.fm).  This is an implementation of the API [specification](https://docs.synq.fm/api/#!/video/create).  You can view the Elixir API reference [here](https://hexdocs.pm/synq_elixir/api-reference.html)

## Installation

Add SynqElixir to your list of dependencies in `mix.exs`:

        def deps do
          [{:synq_elixir, github: "SYNQfm/SYNQ-Elixir"}]
        end

Or from hex:

        def deps do
          [{:synq_elixir, "~> 0.0.1"}]
        end

Ensure you list `synq_elixir` in application dependency in your mix.exs file.

        [applications: [:synq_elixir]]

## Usage

You can use the functions in `SynqElixir.Api` for making requests to RESTful api of Synq.fm. There are shorthand functions that wrap the common get requests

You can also run convenience tasks that will help you testing creating of videos

```
# create a video object
mix synq_task -c create

# get details for video 123
mix synq_task -c details -v 123

# upload file to video object
mix synq_task -c upload -v 123 -f myfile.mp4
```

### Examples

```elixir
# Create video
SynqElixir.Api.create()

# Create video with custom metadata
SynqElixir.Api.create(%{foo: "bar"})

# Get video details for video '123'
SynqElixir.Api.details("123")

# upload video file to the video object
SynqElixir.Api.upload("123", "~/Downloads/myvideofile.mp4")
```

### Overriding Environment

By default, we'll use the `prod` environment. You can override the default environment by exporting the environment variable `SYNQ_ENV` which can be set `stage` or `prod`

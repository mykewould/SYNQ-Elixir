[![CircleCI](https://circleci.com/gh/SYNQfm/SYNQ-Elixir.svg?style=svg)](https://circleci.com/gh/SYNQfm/SYNQ-Elixir)

# Elixir SDK for Synq API

Welcome to the Elixir SDK for the [Synq API](docs.synq.fm).  This is an implementation of the API [specification](https://docs.synq.fm/api/#!/video/create)

## Installation

Add SynqElixir to your list of dependencies in `mix.exs`:

        def deps do
          [{:synq-elixir, github: "SYNQfm/SYNQ-Elixir"}]
        end

Or from hex:

        def deps do
          [{:synq-elixir, "~> 0.0.1"}]
        end

Ensure you list `SynqElixir` in application dependency in your mix.exs file.

        [applications: [:SynqElixir]]

## Usage

You can use the functions in `SynqElixir.Api` for making requests to RESTful api of Synq.fm. There are shorthand functions that wrap the common get requests

You can also run convenience tasks that will help you testing creating of videos

```
# create a video object
mix synq_task -c create
```

### Examples

```elixir
SynqElixir.Api.create()

SynqElixir.Api.create(%{foo: "bar"})

SynqElixir.Api.details("123")

SynqElixir.Api.upload(video_id, file)

```

### Overriding Environment

By default, we'll use the `prod` environment. You can override the default environment by exporting the environment variable `SYNQ_ENV` which can be set `stage` or `prod`

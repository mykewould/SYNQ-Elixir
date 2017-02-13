defmodule Mix.Tasks.SynqTask do
  use Mix.Task
  import SynqElixir.Helpers.{CommonHelper}
  alias SynqElixir.Api

  @moduledoc """
  Simple tasks to test the Synq API

  ## Command Line Options
    * `--command / -c` - select the command you want to run (create)
    * `--file / -f` - select file to upload
    * `--video_id / -v` - video id to use
    * `--metadata / -m` - json data for user metadata
  """

  def display_time(unit) do
    secs = System.convert_time_unit(unit, :native, :seconds)
    cond do
      secs > 86400 -> "#{Float.to_string(secs / 86400, decimals: 2)}d"
      secs > 3600 -> "#{Float.to_string(secs / 3600, decimals: 2)}h"
      true -> "#{secs}s"
    end
  end

  def run(args) do
    Application.ensure_all_started(:synq_elixir)
    {opts, _, _} = OptionParser.parse(args,
      switches: [ command: :string, file: :string
                 ],
      aliases: [c: :command, f: :file]
      )
    start = System.monotonic_time()
    opts_map = opts |> Enum.into(%{})
    process(opts_map)
    taken = System.monotonic_time() - start
    log("took #{display_time(taken)}")
  end

  def process(%{command: "create"} = opts) do
    metadata = opts[:metadata] || %{}
    log("creating video")
    case Api.create(metadata) do
      {:error, %{"name" => "missing_parameter", "message" => msg, "details" => %{"missing" => key}} = details, status} ->
        log("error creating the video : #{status}, missing param '#{key}'")
      {:error, %{"name" => "missing_parameter"} = details, status} ->
        log("error creating the video : #{status}, #{inspect details}")
      {:ok, video} ->
        log("created video #{video.video_id}")
    end
  end

  def process(%{command: "create", file: file} = opts) do
    log("creating video with file #{file}")
  end
end

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
      switches: [ command: :string, file: :string, video_id: :string, metadata: :string
                 ],
      aliases: [c: :command, f: :file, v: :video_id, m: :metadata]
      )
    start = System.monotonic_time()
    opts_map = opts |> Enum.into(%{})
    process(opts_map)
    taken = System.monotonic_time() - start
    log("took #{display_time(taken)}")
  end

  def process(%{command: "create", file: file} = opts) do
    metadata = opts[:metadata] || %{}
    log("creating video with file '#{file}'")
    resp = Api.create(file, metadata)
    case Api.handle_resp(resp, "create and upload") do
      {:error, msg} -> log(msg)
      {:ok, {video, %{"Location" => loc}}} -> log("created video #{video.video_id}, uploaded to #{loc}")
    end
  end

  def process(%{command: "create"} = opts) do
    metadata = opts[:metadata] || %{}
    log("creating video")
    resp = Api.create(metadata)
    case Api.handle_resp(resp, "creating the video") do
      {:error, msg} -> log(msg)
      {:ok, video} -> log("created video #{video.video_id}")
    end
  end

  def process(%{command: cmd, video_id: vid} = opts) when cmd in ["details", "detail"] do
    resp = Api.details(vid)
    case Api.handle_resp(resp, "getting video details") do
      {:error, msg} -> log(msg)
      {:ok, video} -> log("video detail #{inspect video}")
    end
  end

  def process(%{command: "upload", file: file, video_id: vid} = opts) do
    unless File.exists?(file) do
      log("File '#{file}' does not exist")
      exit(1)
    end
    log("uploading video file '#{file}' for #{vid}")
    resp = Api.upload(vid, file)
    case Api.handle_resp(resp, "uploading video") do
      {:error, msg} -> log(msg)
      {:ok, %{"Location" => loc}} -> log("uploaded video to #{loc}")
      _ -> log("unknown resp #{inspect resp}")
    end
  end

  def process(%{command: "create", file: file} = opts) do
    log("creating video with file #{file}")
  end
end

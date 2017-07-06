defmodule SynqElixir.Helpers.CommonHelper do
  @moduledoc """
  Set of common helper functions
  """

  def log(out, true), do: log(out <> " (SIMULATE)")
  def log(out, _), do: log(out)
  def log(out), do: IO.puts("[#{current_time()}] -- " <> out)

  def current_time, do: DateTime.utc_now() |> DateTime.to_iso8601()
end

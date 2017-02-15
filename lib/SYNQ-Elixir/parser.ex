defmodule SynqElixir.Parser do
  @moduledoc """
  A parser to parse Synq.fm responses
  """

  @type status_code :: integer
  @type response :: {:ok, [struct]} | {:ok, struct} | :ok | {:error, map, status_code} | {:error, map} | any

  @spec parse(tuple, any) :: SynqElixir.response
  def parse(response, nil), do: parse(response)
  def parse(response, module) when not is_nil(module) do
    case response do
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} when status in [200, 201] ->
        decoded_body =
          case body |> String.starts_with?("[") do
            true ->
              body
              |> Poison.decode!(as: [module])
            false ->
              body
              |> Poison.decode!(as: module)
          end
        {:ok, decoded_body}
      _ -> parse(response, nil)
    end
  end

  @spec parse(tuple) :: SynqElixir.response
  def parse(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} when status in [200, 201] ->
        Poison.decode(body)
      {:ok, %HTTPoison.Response{body: _, headers: headers, status_code: 204}} when length(headers) > 0 ->
        {:ok, Enum.into(headers, %{})}
      {:ok, %HTTPoison.Response{body: _, headers: _, status_code: 204}} ->
        {:ok, %{}}
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} ->
        {:ok, json} = Poison.decode(body)
        {:error, json, status}
      {:error, %HTTPoison.Error{id: _, reason: reason}} ->
        {:error, %{reason: reason}}
      _ ->
        response
    end
  end
end

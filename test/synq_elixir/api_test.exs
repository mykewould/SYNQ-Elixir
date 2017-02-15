defmodule SynqElixirApiTest do
  use ExUnit.Case
  alias SynqElixir.Api
  import SynqElixir.TestHelpers
  doctest SynqElixir

  setup do
    # delete the SYNQ_ENV
    System.delete_env("SYNQ_ENV")
    # put fake SYNQ_API_KEY
    System.put_env("SYNQ_API_KEY", "abc")
  end

  test "create should handle request correctly" do
    response = fake_response(%{video_id: 10}, 201)
    params = {:form, [{"api_key", "abc"}]}
    mock :post_data, response, params, fn ->
      assert {:ok, %SynqElixir.Resources.Video{video_id: 10}} === Api.create(%{})
    end
  end

  test "create with user data works correctly" do
    user_data = %{foo: "bar"}
    response = fake_response(%{video_id: 1, state: "uploaded"}, 200)
    data = %{"api_key" => "abc", "userdata" => Poison.encode!(user_data)}
    params = {:form, Map.to_list(data)}
    mock :post_data, response, params, fn ->
      assert {:ok, %SynqElixir.Resources.Video{video_id: 1, state: "uploaded"}} === Api.create(user_data)
    end
  end

  test "synq_post should handle upload correctly" do
    response = fake_response(%{"key" => "abc"}, 200)
    data = %{"video_id" => "123"}
    params = {:form, Map.to_list(%{"api_key" => "abc", "video_id" => "123"})}
    mock :post_data, response, params, fn ->
      assert {:ok, %{"key" => "abc"}} === Api.synq_post(:upload, data)
    end
  end

  test "details should return the resources that exist" do
    response = fake_response(%{video_id: 1, state: "created"}, 200)
    mock :post, response, fn ->
      assert {:ok, %SynqElixir.Resources.Video{video_id: 1, state: "created"}} === Api.details(1)
    end
  end

  test "url returns appropriate url" do
    assert Api.url(:test) === Api.url(:prod)
    assert Api.url(:unknownenv) === Api.url(:prod)
    assert Api.url === Api.url(:prod)
    assert Api.url(:stage) === "https://api-staging.synq.fm"
  end

  test "url returns appropriate url based on System environment" do
    System.put_env("SYNQ_ENV", "stage")
    assert Api.url === Api.url(:stage)
    System.put_env("SYNQ_ENV", "prod")
    assert Api.url === Api.url(:prod)
  end
end

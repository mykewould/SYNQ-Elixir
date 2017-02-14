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
    params = URI.encode_query(%{"api_key" => "abc"})
    mock :post_data, response, params, fn ->
      assert {:ok, %SynqElixir.Resources.Video{video_id: 10}} === Api.create(%{})
    end
  end

  test "create with user data works correctly" do
    user_data = %{foo: "bar"}
    response = fake_response(%{video_id: 1, state: "uploaded"}, 200)
    params = URI.encode_query(%{"api_key" => "abc", "userdata" => Poison.encode!(user_data)})
    mock :post_data, response, params, fn ->
      assert {:ok, %SynqElixir.Resources.Video{video_id: 1, state: "uploaded"}} === Api.create(user_data)
    end
  end

  # test "details should return the resources that exist" do
  #   response = fake_response([%{video_id: 1, state: "uploaded"}, %{video_id: 2, state: "created"}], 200)
  #   mock :get, response, fn ->
  #     assert {:ok, [%SynqElixir.Resources.Video{video_id: 1, state: "uploaded"}, %SynqElixir.Resources.Video{video_id: 2, state: "created"}]} === Api.find(SynqElixir.Resources.Video)
  #   end

  #   response = fake_response(%{errors: %{"detail" => "unauthorized"}}, 401)
  #   mock :get, response, fn ->
  #     assert {:error, %{"detail" => "unauthorized"}, 401} === Api.find(SynqElixir.Resources.Video)
  #   end
  # end

  # test "get_video works correctly" do
  #   response = fake_response(%{id: 1, name: "XYZ"}, 200)
  #   mock :get, response, fn ->
  #     assert {:ok, %SynqElixir.Resources.Video{id: 1, name: "XYZ"}} === Api.get_video(1)
  #   end
  # end

  test "process_url/1 creates correct url path" do
    System.put_env("SYNQ_ENV", "stage")
    assert Api.process_url("/awesome") === "#{Api.url(:stage)}/awesome"
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

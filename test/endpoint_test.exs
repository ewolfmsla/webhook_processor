defmodule WebhookProcessor.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias WebhookProcessor.Person

  @opts WebhookProcessor.Endpoint.init([])

  @tag :skip
  test "it returns pong" do
    # Create a test connection
    conn = conn(:get, "/ping")

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "pong!"
  end

  test "it returns 200 with a valid payload" do
    # Create a test connection
    conn = conn(:post, "/events", %{events: [%{}]})

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 200

    assert %{"events" => [%{}]} == conn.body_params
    assert "{\"response\":\"Received Events!\"}" == conn.resp_body
  end

  test "it returns person struct" do
    conn = conn(:get, "/person")

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 200

    assert %Person{} = person = Poison.decode!(conn.resp_body, as: %Person{})

    assert "Eric" == person.name
    assert 62 = person.age
  end

  test "it returns 422 with an invalid payload" do
    # Create a test connection
    conn = conn(:post, "/events", %{})

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 422
  end

  test "it returns 404 when no route matches" do
    # Create a test connection
    conn = conn(:get, "/fail")

    # Invoke the plug
    conn = WebhookProcessor.Endpoint.call(conn, @opts)

    # Assert the response
    assert conn.status == 404
  end
end

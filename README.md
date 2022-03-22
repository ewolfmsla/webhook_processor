# WebhookProcessor

Simple web server using cowboy and plug

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `webhook_processor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    # This will pull in Plug AND Cowboy
    {:plug_cowboy, "~> 2.5"},
    {:poison, "~> 5.0"}
  ] 
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/webhook_processor>.


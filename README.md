# Combo.PubSub

> Distributed PubSub and Presence.

[![Build Status](https://github.com/combo-lab/combo_pubsub/actions/workflows/ci.yml/badge.svg)](https://github.com/combo-lab/combo_pubsub/actions/workflows/ci.yml)

## Usage

Add `:combo_pubsub` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:combo_pubsub, "~> 2.0"}]
end
```

Then start your PubSub instance:

```elixir
defmodule MyApp do
  use Application

  def start(_type, _args) do
    children = [
      {Combo.PubSub, name: MyApp.PubSub}
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

Now broadcast and subscribe:

```elixir
Combo.PubSub.subscribe(MyApp.PubSub, "user:123")
Combo.PubSub.broadcast(MyApp.PubSub, "user:123", :hello_world)
```

## Testing

Testing by default spawns nodes internally for distributed tests.
To run tests that do not require clustering, exclude the `clustered` tag:

```shell
$ mix test --exclude clustered
```

If you have issues running the clustered tests try running:

```shell
$ epmd -daemon
```

before running the tests.

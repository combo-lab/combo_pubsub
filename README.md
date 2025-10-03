# Combo.PubSub

[![CI](https://github.com/combo-lab/combo_pubsub/actions/workflows/ci.yml/badge.svg)](https://github.com/combo-lab/combo_pubsub/actions/workflows/ci.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/combo_pubsub.svg)](https://hex.pm/packages/combo_pubsub)

Distributed Pub/Sub system and presence tracking system.

## Installation

Add `:combo_pubsub` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:combo_pubsub, "<requirement>"}
  ]
end
```

## Usage

For more information, see the [documentation](https://hexdocs.pm/combo_pubsub).

## Testing

Testing by default spawns nodes internally for distributed tests.
To run tests that do not require clustering, exclude the `clustered` tag:

```console
$ mix test --exclude clustered
```

If you have issues running the clustered tests try running:

```console
$ epmd -daemon
```

before running the tests.

## License

[MIT](./LICENSE)

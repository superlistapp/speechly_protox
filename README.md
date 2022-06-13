# SpeechlyProtox

This repository contains the generated [protox](https://hex.pm/packages/protox) modules for the [Speechly gRPC API](https://github.com/speechly/api).

## Installation

The package can be installed by adding `speechly_protox` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:speechly_protox, github: "superlistapp/speechly_protox"}
  ]
end
```

## Generate elixir modules from protobuf

```bash
MIX_ENV=prod mix protox.generate --output-path=./lib --include-path=./api/proto api/proto/speechly/slu/v1/slu.proto api/proto/speechly/slu/v1/wlu.proto api/proto/speechly/sal/v1/compiler.proto api/proto/speechly/identity/v2/identity.proto api/proto/speechly/identity/v2/identity_api.proto api/proto/speechly/config/v1/config_api.proto api/proto/speechly/analytics/v1/analytics.proto api/proto/speechly/analytics/v1/analytics_api.proto --multiple-files
```

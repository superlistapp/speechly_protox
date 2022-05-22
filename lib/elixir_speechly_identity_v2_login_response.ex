# credo:disable-for-this-file
defmodule Speechly.Identity.V2.LoginResponse do
  @moduledoc false
  defstruct token: "", valid_for_s: 0, expires_at_epoch: 0, expires_at: "", __uf__: []

  (
    (
      @spec encode(struct) :: {:ok, iodata} | {:error, any}
      def encode(msg) do
        try do
          {:ok, encode!(msg)}
        rescue
          e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
        end
      end

      @spec encode!(struct) :: iodata | no_return
      def encode!(msg) do
        []
        |> encode_token(msg)
        |> encode_valid_for_s(msg)
        |> encode_expires_at_epoch(msg)
        |> encode_expires_at(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_token(acc, msg) do
        try do
          if msg.token == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_string(msg.token)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:token, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_valid_for_s(acc, msg) do
        try do
          if msg.valid_for_s == 0 do
            acc
          else
            [acc, "\x10", Protox.Encode.encode_uint32(msg.valid_for_s)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:valid_for_s, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_expires_at_epoch(acc, msg) do
        try do
          if msg.expires_at_epoch == 0 do
            acc
          else
            [acc, "\x18", Protox.Encode.encode_uint64(msg.expires_at_epoch)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:expires_at_epoch, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_expires_at(acc, msg) do
        try do
          if msg.expires_at == "" do
            acc
          else
            [acc, "\"", Protox.Encode.encode_string(msg.expires_at)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:expires_at, "invalid field value"), __STACKTRACE__
        end
      end
    ]

    defp encode_unknown_fields(acc, msg) do
      Enum.reduce(msg.__struct__.unknown_fields(msg), acc, fn {tag, wire_type, bytes}, acc ->
        case wire_type do
          0 ->
            [acc, Protox.Encode.make_key_bytes(tag, :int32), bytes]

          1 ->
            [acc, Protox.Encode.make_key_bytes(tag, :double), bytes]

          2 ->
            len_bytes = bytes |> byte_size() |> Protox.Varint.encode()
            [acc, Protox.Encode.make_key_bytes(tag, :packed), len_bytes, bytes]

          5 ->
            [acc, Protox.Encode.make_key_bytes(tag, :float), bytes]
        end
      end)
    end
  )

  (
    (
      @spec decode(binary) :: {:ok, struct} | {:error, any}
      def decode(bytes) do
        try do
          {:ok, decode!(bytes)}
        rescue
          e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
            {:error, e}
        end
      end

      (
        @spec decode!(binary) :: struct | no_return
        def decode!(bytes) do
          parse_key_value(bytes, struct(Speechly.Identity.V2.LoginResponse))
        end
      )
    )

    (
      @spec parse_key_value(binary, struct) :: struct
      defp parse_key_value(<<>>, msg) do
        msg
      end

      defp parse_key_value(bytes, msg) do
        {field, rest} =
          case Protox.Decode.parse_key(bytes) do
            {0, _, _} ->
              raise %Protox.IllegalTagError{}

            {1, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[token: delimited], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint32(bytes)
              {[valid_for_s: value], rest}

            {3, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint64(bytes)
              {[expires_at_epoch: value], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[expires_at: delimited], rest}

            {tag, wire_type, rest} ->
              {value, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)

              {[
                 {msg.__struct__.unknown_fields_name,
                  [value | msg.__struct__.unknown_fields(msg)]}
               ], rest}
          end

        msg_updated = struct(msg, field)
        parse_key_value(rest, msg_updated)
      end
    )

    []
  )

  (
    @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
    def json_decode(input, opts \\ []) do
      try do
        {:ok, json_decode!(input, opts)}
      rescue
        e in Protox.JsonDecodingError -> {:error, e}
      end
    end

    @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
    def json_decode!(input, opts \\ []) do
      {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

      Protox.JsonDecode.decode!(
        input,
        Speechly.Identity.V2.LoginResponse,
        &json_library_wrapper.decode!(json_library, &1)
      )
    end

    @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
    def json_encode(msg, opts \\ []) do
      try do
        {:ok, json_encode!(msg, opts)}
      rescue
        e in Protox.JsonEncodingError -> {:error, e}
      end
    end

    @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
    def json_encode!(msg, opts \\ []) do
      {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
      Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
    end
  )

  (
    @deprecated "Use fields_defs()/0 instead"
    @spec defs() :: %{
            required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs() do
      %{
        1 => {:token, {:scalar, ""}, :string},
        2 => {:valid_for_s, {:scalar, 0}, :uint32},
        3 => {:expires_at_epoch, {:scalar, 0}, :uint64},
        4 => {:expires_at, {:scalar, ""}, :string}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        expires_at: {4, {:scalar, ""}, :string},
        expires_at_epoch: {3, {:scalar, 0}, :uint64},
        token: {1, {:scalar, ""}, :string},
        valid_for_s: {2, {:scalar, 0}, :uint32}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "token",
          kind: {:scalar, ""},
          label: :optional,
          name: :token,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "validForS",
          kind: {:scalar, 0},
          label: :optional,
          name: :valid_for_s,
          tag: 2,
          type: :uint32
        },
        %{
          __struct__: Protox.Field,
          json_name: "expiresAtEpoch",
          kind: {:scalar, 0},
          label: :optional,
          name: :expires_at_epoch,
          tag: 3,
          type: :uint64
        },
        %{
          __struct__: Protox.Field,
          json_name: "expiresAt",
          kind: {:scalar, ""},
          label: :optional,
          name: :expires_at,
          tag: 4,
          type: :string
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:token) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "token",
             kind: {:scalar, ""},
             label: :optional,
             name: :token,
             tag: 1,
             type: :string
           }}
        end

        def field_def("token") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "token",
             kind: {:scalar, ""},
             label: :optional,
             name: :token,
             tag: 1,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:valid_for_s) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "validForS",
             kind: {:scalar, 0},
             label: :optional,
             name: :valid_for_s,
             tag: 2,
             type: :uint32
           }}
        end

        def field_def("validForS") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "validForS",
             kind: {:scalar, 0},
             label: :optional,
             name: :valid_for_s,
             tag: 2,
             type: :uint32
           }}
        end

        def field_def("valid_for_s") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "validForS",
             kind: {:scalar, 0},
             label: :optional,
             name: :valid_for_s,
             tag: 2,
             type: :uint32
           }}
        end
      ),
      (
        def field_def(:expires_at_epoch) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expiresAtEpoch",
             kind: {:scalar, 0},
             label: :optional,
             name: :expires_at_epoch,
             tag: 3,
             type: :uint64
           }}
        end

        def field_def("expiresAtEpoch") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expiresAtEpoch",
             kind: {:scalar, 0},
             label: :optional,
             name: :expires_at_epoch,
             tag: 3,
             type: :uint64
           }}
        end

        def field_def("expires_at_epoch") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expiresAtEpoch",
             kind: {:scalar, 0},
             label: :optional,
             name: :expires_at_epoch,
             tag: 3,
             type: :uint64
           }}
        end
      ),
      (
        def field_def(:expires_at) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expiresAt",
             kind: {:scalar, ""},
             label: :optional,
             name: :expires_at,
             tag: 4,
             type: :string
           }}
        end

        def field_def("expiresAt") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expiresAt",
             kind: {:scalar, ""},
             label: :optional,
             name: :expires_at,
             tag: 4,
             type: :string
           }}
        end

        def field_def("expires_at") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expiresAt",
             kind: {:scalar, ""},
             label: :optional,
             name: :expires_at,
             tag: 4,
             type: :string
           }}
        end
      ),
      def field_def(_) do
        {:error, :no_such_field}
      end
    ]
  )

  (
    @spec unknown_fields(struct) :: [{non_neg_integer, Protox.Types.tag(), binary}]
    def unknown_fields(msg) do
      msg.__uf__
    end

    @spec unknown_fields_name() :: :__uf__
    def unknown_fields_name() do
      :__uf__
    end

    @spec clear_unknown_fields(struct) :: struct
    def clear_unknown_fields(msg) do
      struct!(msg, [{unknown_fields_name(), []}])
    end
  )

  (
    @spec required_fields() :: []
    def required_fields() do
      []
    end
  )

  (
    @spec syntax() :: atom()
    def syntax() do
      :proto3
    end
  )

  [
    @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
    def default(:token) do
      {:ok, ""}
    end,
    def default(:valid_for_s) do
      {:ok, 0}
    end,
    def default(:expires_at_epoch) do
      {:ok, 0}
    end,
    def default(:expires_at) do
      {:ok, ""}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

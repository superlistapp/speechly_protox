# credo:disable-for-this-file
defmodule Speechly.Slu.V1.WLUEntity do
  @moduledoc false
  defstruct entity: "", value: "", start_position: 0, end_position: 0, __uf__: []

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
        |> encode_entity(msg)
        |> encode_value(msg)
        |> encode_start_position(msg)
        |> encode_end_position(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_entity(acc, msg) do
        try do
          if msg.entity == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_string(msg.entity)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:entity, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_value(acc, msg) do
        try do
          if msg.value == "" do
            acc
          else
            [acc, "\x12", Protox.Encode.encode_string(msg.value)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:value, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_start_position(acc, msg) do
        try do
          if msg.start_position == 0 do
            acc
          else
            [acc, "\x18", Protox.Encode.encode_int32(msg.start_position)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:start_position, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_end_position(acc, msg) do
        try do
          if msg.end_position == 0 do
            acc
          else
            [acc, " ", Protox.Encode.encode_int32(msg.end_position)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:end_position, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Speechly.Slu.V1.WLUEntity))
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
              {[entity: delimited], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[value: delimited], rest}

            {3, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[start_position: value], rest}

            {4, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[end_position: value], rest}

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
        Speechly.Slu.V1.WLUEntity,
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
        1 => {:entity, {:scalar, ""}, :string},
        2 => {:value, {:scalar, ""}, :string},
        3 => {:start_position, {:scalar, 0}, :int32},
        4 => {:end_position, {:scalar, 0}, :int32}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        end_position: {4, {:scalar, 0}, :int32},
        entity: {1, {:scalar, ""}, :string},
        start_position: {3, {:scalar, 0}, :int32},
        value: {2, {:scalar, ""}, :string}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "entity",
          kind: {:scalar, ""},
          label: :optional,
          name: :entity,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "value",
          kind: {:scalar, ""},
          label: :optional,
          name: :value,
          tag: 2,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "startPosition",
          kind: {:scalar, 0},
          label: :optional,
          name: :start_position,
          tag: 3,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "endPosition",
          kind: {:scalar, 0},
          label: :optional,
          name: :end_position,
          tag: 4,
          type: :int32
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:entity) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "entity",
             kind: {:scalar, ""},
             label: :optional,
             name: :entity,
             tag: 1,
             type: :string
           }}
        end

        def field_def("entity") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "entity",
             kind: {:scalar, ""},
             label: :optional,
             name: :entity,
             tag: 1,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:value) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "value",
             kind: {:scalar, ""},
             label: :optional,
             name: :value,
             tag: 2,
             type: :string
           }}
        end

        def field_def("value") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "value",
             kind: {:scalar, ""},
             label: :optional,
             name: :value,
             tag: 2,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:start_position) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startPosition",
             kind: {:scalar, 0},
             label: :optional,
             name: :start_position,
             tag: 3,
             type: :int32
           }}
        end

        def field_def("startPosition") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startPosition",
             kind: {:scalar, 0},
             label: :optional,
             name: :start_position,
             tag: 3,
             type: :int32
           }}
        end

        def field_def("start_position") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startPosition",
             kind: {:scalar, 0},
             label: :optional,
             name: :start_position,
             tag: 3,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:end_position) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endPosition",
             kind: {:scalar, 0},
             label: :optional,
             name: :end_position,
             tag: 4,
             type: :int32
           }}
        end

        def field_def("endPosition") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endPosition",
             kind: {:scalar, 0},
             label: :optional,
             name: :end_position,
             tag: 4,
             type: :int32
           }}
        end

        def field_def("end_position") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endPosition",
             kind: {:scalar, 0},
             label: :optional,
             name: :end_position,
             tag: 4,
             type: :int32
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
    def default(:entity) do
      {:ok, ""}
    end,
    def default(:value) do
      {:ok, ""}
    end,
    def default(:start_position) do
      {:ok, 0}
    end,
    def default(:end_position) do
      {:ok, 0}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

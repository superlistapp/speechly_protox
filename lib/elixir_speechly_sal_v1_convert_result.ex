# credo:disable-for-this-file
defmodule Speechly.Sal.V1.ConvertResult do
  @moduledoc false
  defstruct status: :CONVERT_SUCCESS, warnings: "", result: nil, __uf__: []

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
        |> encode_status(msg)
        |> encode_warnings(msg)
        |> encode_result(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_status(acc, msg) do
        try do
          if msg.status == :CONVERT_SUCCESS do
            acc
          else
            [
              acc,
              "\b",
              msg.status
              |> Speechly.Sal.V1.ConvertResult.Status.encode()
              |> Protox.Encode.encode_enum()
            ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:status, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_warnings(acc, msg) do
        try do
          if msg.warnings == "" do
            acc
          else
            [acc, "\x12", Protox.Encode.encode_string(msg.warnings)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:warnings, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_result(acc, msg) do
        try do
          if msg.result == nil do
            acc
          else
            [acc, "\x1A", Protox.Encode.encode_message(msg.result)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:result, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Speechly.Sal.V1.ConvertResult))
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
              {value, rest} =
                Protox.Decode.parse_enum(bytes, Speechly.Sal.V1.ConvertResult.Status)

              {[status: value], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[warnings: delimited], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 result:
                   Protox.MergeMessage.merge(
                     msg.result,
                     Speechly.Sal.V1.AppSource.decode!(delimited)
                   )
               ], rest}

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
        Speechly.Sal.V1.ConvertResult,
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
        1 =>
          {:status, {:scalar, :CONVERT_SUCCESS}, {:enum, Speechly.Sal.V1.ConvertResult.Status}},
        2 => {:warnings, {:scalar, ""}, :string},
        3 => {:result, {:scalar, nil}, {:message, Speechly.Sal.V1.AppSource}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        result: {3, {:scalar, nil}, {:message, Speechly.Sal.V1.AppSource}},
        status: {1, {:scalar, :CONVERT_SUCCESS}, {:enum, Speechly.Sal.V1.ConvertResult.Status}},
        warnings: {2, {:scalar, ""}, :string}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "status",
          kind: {:scalar, :CONVERT_SUCCESS},
          label: :optional,
          name: :status,
          tag: 1,
          type: {:enum, Speechly.Sal.V1.ConvertResult.Status}
        },
        %{
          __struct__: Protox.Field,
          json_name: "warnings",
          kind: {:scalar, ""},
          label: :optional,
          name: :warnings,
          tag: 2,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "result",
          kind: {:scalar, nil},
          label: :optional,
          name: :result,
          tag: 3,
          type: {:message, Speechly.Sal.V1.AppSource}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:status) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "status",
             kind: {:scalar, :CONVERT_SUCCESS},
             label: :optional,
             name: :status,
             tag: 1,
             type: {:enum, Speechly.Sal.V1.ConvertResult.Status}
           }}
        end

        def field_def("status") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "status",
             kind: {:scalar, :CONVERT_SUCCESS},
             label: :optional,
             name: :status,
             tag: 1,
             type: {:enum, Speechly.Sal.V1.ConvertResult.Status}
           }}
        end

        []
      ),
      (
        def field_def(:warnings) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "warnings",
             kind: {:scalar, ""},
             label: :optional,
             name: :warnings,
             tag: 2,
             type: :string
           }}
        end

        def field_def("warnings") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "warnings",
             kind: {:scalar, ""},
             label: :optional,
             name: :warnings,
             tag: 2,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:result) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "result",
             kind: {:scalar, nil},
             label: :optional,
             name: :result,
             tag: 3,
             type: {:message, Speechly.Sal.V1.AppSource}
           }}
        end

        def field_def("result") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "result",
             kind: {:scalar, nil},
             label: :optional,
             name: :result,
             tag: 3,
             type: {:message, Speechly.Sal.V1.AppSource}
           }}
        end

        []
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
    def default(:status) do
      {:ok, :CONVERT_SUCCESS}
    end,
    def default(:warnings) do
      {:ok, ""}
    end,
    def default(:result) do
      {:ok, nil}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

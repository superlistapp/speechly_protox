# credo:disable-for-this-file
defmodule Speechly.Config.V1.DownloadCurrentTrainingDataResponse do
  @moduledoc false
  defstruct data_chunk: "", content_type: :CONTENT_TYPE_UNSPECIFIED, __uf__: []

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
        [] |> encode_data_chunk(msg) |> encode_content_type(msg) |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_data_chunk(acc, msg) do
        try do
          if msg.data_chunk == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_bytes(msg.data_chunk)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:data_chunk, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_content_type(acc, msg) do
        try do
          if msg.content_type == :CONTENT_TYPE_UNSPECIFIED do
            acc
          else
            [
              acc,
              "\x10",
              msg.content_type
              |> Speechly.Config.V1.DownloadCurrentTrainingDataResponse.ContentType.encode()
              |> Protox.Encode.encode_enum()
            ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:content_type, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Speechly.Config.V1.DownloadCurrentTrainingDataResponse))
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
              {[data_chunk: delimited], rest}

            {2, _, bytes} ->
              {value, rest} =
                Protox.Decode.parse_enum(
                  bytes,
                  Speechly.Config.V1.DownloadCurrentTrainingDataResponse.ContentType
                )

              {[content_type: value], rest}

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
        Speechly.Config.V1.DownloadCurrentTrainingDataResponse,
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
        1 => {:data_chunk, {:scalar, ""}, :bytes},
        2 =>
          {:content_type, {:scalar, :CONTENT_TYPE_UNSPECIFIED},
           {:enum, Speechly.Config.V1.DownloadCurrentTrainingDataResponse.ContentType}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        content_type:
          {2, {:scalar, :CONTENT_TYPE_UNSPECIFIED},
           {:enum, Speechly.Config.V1.DownloadCurrentTrainingDataResponse.ContentType}},
        data_chunk: {1, {:scalar, ""}, :bytes}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "dataChunk",
          kind: {:scalar, ""},
          label: :optional,
          name: :data_chunk,
          tag: 1,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "contentType",
          kind: {:scalar, :CONTENT_TYPE_UNSPECIFIED},
          label: :optional,
          name: :content_type,
          tag: 2,
          type: {:enum, Speechly.Config.V1.DownloadCurrentTrainingDataResponse.ContentType}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:data_chunk) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "dataChunk",
             kind: {:scalar, ""},
             label: :optional,
             name: :data_chunk,
             tag: 1,
             type: :bytes
           }}
        end

        def field_def("dataChunk") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "dataChunk",
             kind: {:scalar, ""},
             label: :optional,
             name: :data_chunk,
             tag: 1,
             type: :bytes
           }}
        end

        def field_def("data_chunk") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "dataChunk",
             kind: {:scalar, ""},
             label: :optional,
             name: :data_chunk,
             tag: 1,
             type: :bytes
           }}
        end
      ),
      (
        def field_def(:content_type) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "contentType",
             kind: {:scalar, :CONTENT_TYPE_UNSPECIFIED},
             label: :optional,
             name: :content_type,
             tag: 2,
             type: {:enum, Speechly.Config.V1.DownloadCurrentTrainingDataResponse.ContentType}
           }}
        end

        def field_def("contentType") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "contentType",
             kind: {:scalar, :CONTENT_TYPE_UNSPECIFIED},
             label: :optional,
             name: :content_type,
             tag: 2,
             type: {:enum, Speechly.Config.V1.DownloadCurrentTrainingDataResponse.ContentType}
           }}
        end

        def field_def("content_type") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "contentType",
             kind: {:scalar, :CONTENT_TYPE_UNSPECIFIED},
             label: :optional,
             name: :content_type,
             tag: 2,
             type: {:enum, Speechly.Config.V1.DownloadCurrentTrainingDataResponse.ContentType}
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
    def default(:data_chunk) do
      {:ok, ""}
    end,
    def default(:content_type) do
      {:ok, :CONTENT_TYPE_UNSPECIFIED}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end
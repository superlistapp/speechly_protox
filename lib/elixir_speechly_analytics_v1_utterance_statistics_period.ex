# credo:disable-for-this-file
defmodule Speechly.Analytics.V1.UtteranceStatisticsPeriod do
  @moduledoc false
  defstruct app_id: "",
            start_time: "",
            count: 0,
            utterances_seconds: 0,
            annotated_seconds: 0,
            __uf__: []

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
        |> encode_app_id(msg)
        |> encode_start_time(msg)
        |> encode_count(msg)
        |> encode_utterances_seconds(msg)
        |> encode_annotated_seconds(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_app_id(acc, msg) do
        try do
          if msg.app_id == "" do
            acc
          else
            [acc, "\x12", Protox.Encode.encode_string(msg.app_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:app_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_start_time(acc, msg) do
        try do
          if msg.start_time == "" do
            acc
          else
            [acc, "\x1A", Protox.Encode.encode_string(msg.start_time)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:start_time, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_count(acc, msg) do
        try do
          if msg.count == 0 do
            acc
          else
            [acc, " ", Protox.Encode.encode_int32(msg.count)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:count, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_utterances_seconds(acc, msg) do
        try do
          if msg.utterances_seconds == 0 do
            acc
          else
            [acc, "(", Protox.Encode.encode_int32(msg.utterances_seconds)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:utterances_seconds, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_annotated_seconds(acc, msg) do
        try do
          if msg.annotated_seconds == 0 do
            acc
          else
            [acc, "0", Protox.Encode.encode_int32(msg.annotated_seconds)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:annotated_seconds, "invalid field value"),
                    __STACKTRACE__
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
          parse_key_value(bytes, struct(Speechly.Analytics.V1.UtteranceStatisticsPeriod))
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

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[app_id: delimited], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[start_time: delimited], rest}

            {4, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[count: value], rest}

            {5, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[utterances_seconds: value], rest}

            {6, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[annotated_seconds: value], rest}

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
        Speechly.Analytics.V1.UtteranceStatisticsPeriod,
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
        2 => {:app_id, {:scalar, ""}, :string},
        3 => {:start_time, {:scalar, ""}, :string},
        4 => {:count, {:scalar, 0}, :int32},
        5 => {:utterances_seconds, {:scalar, 0}, :int32},
        6 => {:annotated_seconds, {:scalar, 0}, :int32}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        annotated_seconds: {6, {:scalar, 0}, :int32},
        app_id: {2, {:scalar, ""}, :string},
        count: {4, {:scalar, 0}, :int32},
        start_time: {3, {:scalar, ""}, :string},
        utterances_seconds: {5, {:scalar, 0}, :int32}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "appId",
          kind: {:scalar, ""},
          label: :optional,
          name: :app_id,
          tag: 2,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "startTime",
          kind: {:scalar, ""},
          label: :optional,
          name: :start_time,
          tag: 3,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "count",
          kind: {:scalar, 0},
          label: :optional,
          name: :count,
          tag: 4,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "utterancesSeconds",
          kind: {:scalar, 0},
          label: :optional,
          name: :utterances_seconds,
          tag: 5,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "annotatedSeconds",
          kind: {:scalar, 0},
          label: :optional,
          name: :annotated_seconds,
          tag: 6,
          type: :int32
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:app_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "appId",
             kind: {:scalar, ""},
             label: :optional,
             name: :app_id,
             tag: 2,
             type: :string
           }}
        end

        def field_def("appId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "appId",
             kind: {:scalar, ""},
             label: :optional,
             name: :app_id,
             tag: 2,
             type: :string
           }}
        end

        def field_def("app_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "appId",
             kind: {:scalar, ""},
             label: :optional,
             name: :app_id,
             tag: 2,
             type: :string
           }}
        end
      ),
      (
        def field_def(:start_time) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startTime",
             kind: {:scalar, ""},
             label: :optional,
             name: :start_time,
             tag: 3,
             type: :string
           }}
        end

        def field_def("startTime") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startTime",
             kind: {:scalar, ""},
             label: :optional,
             name: :start_time,
             tag: 3,
             type: :string
           }}
        end

        def field_def("start_time") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startTime",
             kind: {:scalar, ""},
             label: :optional,
             name: :start_time,
             tag: 3,
             type: :string
           }}
        end
      ),
      (
        def field_def(:count) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "count",
             kind: {:scalar, 0},
             label: :optional,
             name: :count,
             tag: 4,
             type: :int32
           }}
        end

        def field_def("count") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "count",
             kind: {:scalar, 0},
             label: :optional,
             name: :count,
             tag: 4,
             type: :int32
           }}
        end

        []
      ),
      (
        def field_def(:utterances_seconds) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "utterancesSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :utterances_seconds,
             tag: 5,
             type: :int32
           }}
        end

        def field_def("utterancesSeconds") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "utterancesSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :utterances_seconds,
             tag: 5,
             type: :int32
           }}
        end

        def field_def("utterances_seconds") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "utterancesSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :utterances_seconds,
             tag: 5,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:annotated_seconds) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "annotatedSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :annotated_seconds,
             tag: 6,
             type: :int32
           }}
        end

        def field_def("annotatedSeconds") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "annotatedSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :annotated_seconds,
             tag: 6,
             type: :int32
           }}
        end

        def field_def("annotated_seconds") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "annotatedSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :annotated_seconds,
             tag: 6,
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
    def default(:app_id) do
      {:ok, ""}
    end,
    def default(:start_time) do
      {:ok, ""}
    end,
    def default(:count) do
      {:ok, 0}
    end,
    def default(:utterances_seconds) do
      {:ok, 0}
    end,
    def default(:annotated_seconds) do
      {:ok, 0}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

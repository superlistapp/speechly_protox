# credo:disable-for-this-file
defmodule Speechly.Analytics.V1.UtteranceStatisticsResponse do
  @moduledoc false
  defstruct start_date: "",
            end_date: "",
            aggregation: :AGGREGATION_INVALID,
            items: [],
            total_utterances: 0,
            total_duration_seconds: 0,
            total_annotated_seconds: 0,
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
        |> encode_start_date(msg)
        |> encode_end_date(msg)
        |> encode_aggregation(msg)
        |> encode_items(msg)
        |> encode_total_utterances(msg)
        |> encode_total_duration_seconds(msg)
        |> encode_total_annotated_seconds(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_start_date(acc, msg) do
        try do
          if msg.start_date == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_string(msg.start_date)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:start_date, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_end_date(acc, msg) do
        try do
          if msg.end_date == "" do
            acc
          else
            [acc, "\x12", Protox.Encode.encode_string(msg.end_date)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:end_date, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_aggregation(acc, msg) do
        try do
          if msg.aggregation == :AGGREGATION_INVALID do
            acc
          else
            [
              acc,
              "\x18",
              msg.aggregation
              |> Speechly.Analytics.V1.Aggregation.encode()
              |> Protox.Encode.encode_enum()
            ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:aggregation, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_items(acc, msg) do
        try do
          case msg.items do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "\"", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:items, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_total_utterances(acc, msg) do
        try do
          if msg.total_utterances == 0 do
            acc
          else
            [acc, "(", Protox.Encode.encode_int32(msg.total_utterances)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:total_utterances, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_total_duration_seconds(acc, msg) do
        try do
          if msg.total_duration_seconds == 0 do
            acc
          else
            [acc, "0", Protox.Encode.encode_int32(msg.total_duration_seconds)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:total_duration_seconds, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_total_annotated_seconds(acc, msg) do
        try do
          if msg.total_annotated_seconds == 0 do
            acc
          else
            [acc, "8", Protox.Encode.encode_int32(msg.total_annotated_seconds)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:total_annotated_seconds, "invalid field value"),
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
          parse_key_value(bytes, struct(Speechly.Analytics.V1.UtteranceStatisticsResponse))
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
              {[start_date: delimited], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[end_date: delimited], rest}

            {3, _, bytes} ->
              {value, rest} = Protox.Decode.parse_enum(bytes, Speechly.Analytics.V1.Aggregation)
              {[aggregation: value], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 items:
                   msg.items ++
                     [Speechly.Analytics.V1.UtteranceStatisticsPeriod.decode!(delimited)]
               ], rest}

            {5, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[total_utterances: value], rest}

            {6, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[total_duration_seconds: value], rest}

            {7, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[total_annotated_seconds: value], rest}

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
        Speechly.Analytics.V1.UtteranceStatisticsResponse,
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
        1 => {:start_date, {:scalar, ""}, :string},
        2 => {:end_date, {:scalar, ""}, :string},
        3 =>
          {:aggregation, {:scalar, :AGGREGATION_INVALID},
           {:enum, Speechly.Analytics.V1.Aggregation}},
        4 => {:items, :unpacked, {:message, Speechly.Analytics.V1.UtteranceStatisticsPeriod}},
        5 => {:total_utterances, {:scalar, 0}, :int32},
        6 => {:total_duration_seconds, {:scalar, 0}, :int32},
        7 => {:total_annotated_seconds, {:scalar, 0}, :int32}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        aggregation:
          {3, {:scalar, :AGGREGATION_INVALID}, {:enum, Speechly.Analytics.V1.Aggregation}},
        end_date: {2, {:scalar, ""}, :string},
        items: {4, :unpacked, {:message, Speechly.Analytics.V1.UtteranceStatisticsPeriod}},
        start_date: {1, {:scalar, ""}, :string},
        total_annotated_seconds: {7, {:scalar, 0}, :int32},
        total_duration_seconds: {6, {:scalar, 0}, :int32},
        total_utterances: {5, {:scalar, 0}, :int32}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "startDate",
          kind: {:scalar, ""},
          label: :optional,
          name: :start_date,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "endDate",
          kind: {:scalar, ""},
          label: :optional,
          name: :end_date,
          tag: 2,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "aggregation",
          kind: {:scalar, :AGGREGATION_INVALID},
          label: :optional,
          name: :aggregation,
          tag: 3,
          type: {:enum, Speechly.Analytics.V1.Aggregation}
        },
        %{
          __struct__: Protox.Field,
          json_name: "items",
          kind: :unpacked,
          label: :repeated,
          name: :items,
          tag: 4,
          type: {:message, Speechly.Analytics.V1.UtteranceStatisticsPeriod}
        },
        %{
          __struct__: Protox.Field,
          json_name: "totalUtterances",
          kind: {:scalar, 0},
          label: :optional,
          name: :total_utterances,
          tag: 5,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "totalDurationSeconds",
          kind: {:scalar, 0},
          label: :optional,
          name: :total_duration_seconds,
          tag: 6,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "totalAnnotatedSeconds",
          kind: {:scalar, 0},
          label: :optional,
          name: :total_annotated_seconds,
          tag: 7,
          type: :int32
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:start_date) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startDate",
             kind: {:scalar, ""},
             label: :optional,
             name: :start_date,
             tag: 1,
             type: :string
           }}
        end

        def field_def("startDate") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startDate",
             kind: {:scalar, ""},
             label: :optional,
             name: :start_date,
             tag: 1,
             type: :string
           }}
        end

        def field_def("start_date") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startDate",
             kind: {:scalar, ""},
             label: :optional,
             name: :start_date,
             tag: 1,
             type: :string
           }}
        end
      ),
      (
        def field_def(:end_date) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endDate",
             kind: {:scalar, ""},
             label: :optional,
             name: :end_date,
             tag: 2,
             type: :string
           }}
        end

        def field_def("endDate") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endDate",
             kind: {:scalar, ""},
             label: :optional,
             name: :end_date,
             tag: 2,
             type: :string
           }}
        end

        def field_def("end_date") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "endDate",
             kind: {:scalar, ""},
             label: :optional,
             name: :end_date,
             tag: 2,
             type: :string
           }}
        end
      ),
      (
        def field_def(:aggregation) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "aggregation",
             kind: {:scalar, :AGGREGATION_INVALID},
             label: :optional,
             name: :aggregation,
             tag: 3,
             type: {:enum, Speechly.Analytics.V1.Aggregation}
           }}
        end

        def field_def("aggregation") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "aggregation",
             kind: {:scalar, :AGGREGATION_INVALID},
             label: :optional,
             name: :aggregation,
             tag: 3,
             type: {:enum, Speechly.Analytics.V1.Aggregation}
           }}
        end

        []
      ),
      (
        def field_def(:items) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "items",
             kind: :unpacked,
             label: :repeated,
             name: :items,
             tag: 4,
             type: {:message, Speechly.Analytics.V1.UtteranceStatisticsPeriod}
           }}
        end

        def field_def("items") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "items",
             kind: :unpacked,
             label: :repeated,
             name: :items,
             tag: 4,
             type: {:message, Speechly.Analytics.V1.UtteranceStatisticsPeriod}
           }}
        end

        []
      ),
      (
        def field_def(:total_utterances) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalUtterances",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_utterances,
             tag: 5,
             type: :int32
           }}
        end

        def field_def("totalUtterances") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalUtterances",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_utterances,
             tag: 5,
             type: :int32
           }}
        end

        def field_def("total_utterances") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalUtterances",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_utterances,
             tag: 5,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:total_duration_seconds) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalDurationSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_duration_seconds,
             tag: 6,
             type: :int32
           }}
        end

        def field_def("totalDurationSeconds") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalDurationSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_duration_seconds,
             tag: 6,
             type: :int32
           }}
        end

        def field_def("total_duration_seconds") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalDurationSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_duration_seconds,
             tag: 6,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:total_annotated_seconds) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalAnnotatedSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_annotated_seconds,
             tag: 7,
             type: :int32
           }}
        end

        def field_def("totalAnnotatedSeconds") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalAnnotatedSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_annotated_seconds,
             tag: 7,
             type: :int32
           }}
        end

        def field_def("total_annotated_seconds") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "totalAnnotatedSeconds",
             kind: {:scalar, 0},
             label: :optional,
             name: :total_annotated_seconds,
             tag: 7,
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
    def default(:start_date) do
      {:ok, ""}
    end,
    def default(:end_date) do
      {:ok, ""}
    end,
    def default(:aggregation) do
      {:ok, :AGGREGATION_INVALID}
    end,
    def default(:items) do
      {:error, :no_default_value}
    end,
    def default(:total_utterances) do
      {:ok, 0}
    end,
    def default(:total_duration_seconds) do
      {:ok, 0}
    end,
    def default(:total_annotated_seconds) do
      {:ok, 0}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

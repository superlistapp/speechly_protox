# credo:disable-for-this-file
defmodule Speechly.Analytics.V1.UtteranceStatisticsRequest do
  @moduledoc false
  defstruct app_id: "",
            days: 0,
            scope: :SCOPE_INVALID,
            aggregation: :AGGREGATION_INVALID,
            start_date: "",
            end_date: "",
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
        |> encode_days(msg)
        |> encode_scope(msg)
        |> encode_aggregation(msg)
        |> encode_start_date(msg)
        |> encode_end_date(msg)
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
            [acc, "\n", Protox.Encode.encode_string(msg.app_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:app_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_days(acc, msg) do
        try do
          if msg.days == 0 do
            acc
          else
            [acc, "\x10", Protox.Encode.encode_int32(msg.days)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:days, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_scope(acc, msg) do
        try do
          if msg.scope == :SCOPE_INVALID do
            acc
          else
            [
              acc,
              "\x18",
              msg.scope
              |> Speechly.Analytics.V1.UtteranceStatisticsRequest.Scope.encode()
              |> Protox.Encode.encode_enum()
            ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:scope, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_aggregation(acc, msg) do
        try do
          if msg.aggregation == :AGGREGATION_INVALID do
            acc
          else
            [
              acc,
              " ",
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
      defp encode_start_date(acc, msg) do
        try do
          if msg.start_date == "" do
            acc
          else
            [acc, "*", Protox.Encode.encode_string(msg.start_date)]
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
            [acc, "2", Protox.Encode.encode_string(msg.end_date)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:end_date, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Speechly.Analytics.V1.UtteranceStatisticsRequest))
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
              {[app_id: delimited], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[days: value], rest}

            {3, _, bytes} ->
              {value, rest} =
                Protox.Decode.parse_enum(
                  bytes,
                  Speechly.Analytics.V1.UtteranceStatisticsRequest.Scope
                )

              {[scope: value], rest}

            {4, _, bytes} ->
              {value, rest} = Protox.Decode.parse_enum(bytes, Speechly.Analytics.V1.Aggregation)
              {[aggregation: value], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[start_date: delimited], rest}

            {6, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[end_date: delimited], rest}

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
        Speechly.Analytics.V1.UtteranceStatisticsRequest,
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
        1 => {:app_id, {:scalar, ""}, :string},
        2 => {:days, {:scalar, 0}, :int32},
        3 =>
          {:scope, {:scalar, :SCOPE_INVALID},
           {:enum, Speechly.Analytics.V1.UtteranceStatisticsRequest.Scope}},
        4 =>
          {:aggregation, {:scalar, :AGGREGATION_INVALID},
           {:enum, Speechly.Analytics.V1.Aggregation}},
        5 => {:start_date, {:scalar, ""}, :string},
        6 => {:end_date, {:scalar, ""}, :string}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        aggregation:
          {4, {:scalar, :AGGREGATION_INVALID}, {:enum, Speechly.Analytics.V1.Aggregation}},
        app_id: {1, {:scalar, ""}, :string},
        days: {2, {:scalar, 0}, :int32},
        end_date: {6, {:scalar, ""}, :string},
        scope:
          {3, {:scalar, :SCOPE_INVALID},
           {:enum, Speechly.Analytics.V1.UtteranceStatisticsRequest.Scope}},
        start_date: {5, {:scalar, ""}, :string}
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
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "days",
          kind: {:scalar, 0},
          label: :optional,
          name: :days,
          tag: 2,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "scope",
          kind: {:scalar, :SCOPE_INVALID},
          label: :optional,
          name: :scope,
          tag: 3,
          type: {:enum, Speechly.Analytics.V1.UtteranceStatisticsRequest.Scope}
        },
        %{
          __struct__: Protox.Field,
          json_name: "aggregation",
          kind: {:scalar, :AGGREGATION_INVALID},
          label: :optional,
          name: :aggregation,
          tag: 4,
          type: {:enum, Speechly.Analytics.V1.Aggregation}
        },
        %{
          __struct__: Protox.Field,
          json_name: "startDate",
          kind: {:scalar, ""},
          label: :optional,
          name: :start_date,
          tag: 5,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "endDate",
          kind: {:scalar, ""},
          label: :optional,
          name: :end_date,
          tag: 6,
          type: :string
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
             tag: 1,
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
             tag: 1,
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
             tag: 1,
             type: :string
           }}
        end
      ),
      (
        def field_def(:days) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "days",
             kind: {:scalar, 0},
             label: :optional,
             name: :days,
             tag: 2,
             type: :int32
           }}
        end

        def field_def("days") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "days",
             kind: {:scalar, 0},
             label: :optional,
             name: :days,
             tag: 2,
             type: :int32
           }}
        end

        []
      ),
      (
        def field_def(:scope) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "scope",
             kind: {:scalar, :SCOPE_INVALID},
             label: :optional,
             name: :scope,
             tag: 3,
             type: {:enum, Speechly.Analytics.V1.UtteranceStatisticsRequest.Scope}
           }}
        end

        def field_def("scope") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "scope",
             kind: {:scalar, :SCOPE_INVALID},
             label: :optional,
             name: :scope,
             tag: 3,
             type: {:enum, Speechly.Analytics.V1.UtteranceStatisticsRequest.Scope}
           }}
        end

        []
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
             tag: 4,
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
             tag: 4,
             type: {:enum, Speechly.Analytics.V1.Aggregation}
           }}
        end

        []
      ),
      (
        def field_def(:start_date) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "startDate",
             kind: {:scalar, ""},
             label: :optional,
             name: :start_date,
             tag: 5,
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
             tag: 5,
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
             tag: 5,
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
             tag: 6,
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
             tag: 6,
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
             tag: 6,
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
    def default(:app_id) do
      {:ok, ""}
    end,
    def default(:days) do
      {:ok, 0}
    end,
    def default(:scope) do
      {:ok, :SCOPE_INVALID}
    end,
    def default(:aggregation) do
      {:ok, :AGGREGATION_INVALID}
    end,
    def default(:start_date) do
      {:ok, ""}
    end,
    def default(:end_date) do
      {:ok, ""}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end
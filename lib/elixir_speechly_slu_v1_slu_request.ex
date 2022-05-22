# credo:disable-for-this-file
defmodule Speechly.Slu.V1.SLURequest do
  @moduledoc false
  defstruct streaming_request: nil, __uf__: []

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
        [] |> encode_streaming_request(msg) |> encode_unknown_fields(msg)
      end
    )

    [
      defp encode_streaming_request(acc, msg) do
        case msg.streaming_request do
          nil -> acc
          {:config, _field_value} -> encode_config(acc, msg)
          {:event, _field_value} -> encode_event(acc, msg)
          {:audio, _field_value} -> encode_audio(acc, msg)
          {:rtt_response, _field_value} -> encode_rtt_response(acc, msg)
          {:start, _field_value} -> encode_start(acc, msg)
          {:stop, _field_value} -> encode_stop(acc, msg)
        end
      end
    ]

    [
      defp encode_config(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_request
          [acc, "\n", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:config, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_event(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_request
          [acc, "\x12", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:event, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_audio(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_request
          [acc, "\x1A", Protox.Encode.encode_bytes(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:audio, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_rtt_response(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_request
          [acc, "\"", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:rtt_response, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_start(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_request
          [acc, "*", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:start, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_stop(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_request
          [acc, "2", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:stop, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Speechly.Slu.V1.SLURequest))
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

              {[
                 case msg.streaming_request do
                   {:config, previous_value} ->
                     {:streaming_request,
                      {:config,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUConfig.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_request, {:config, Speechly.Slu.V1.SLUConfig.decode!(delimited)}}
                 end
               ], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_request do
                   {:event, previous_value} ->
                     {:streaming_request,
                      {:event,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUEvent.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_request, {:event, Speechly.Slu.V1.SLUEvent.decode!(delimited)}}
                 end
               ], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[streaming_request: {:audio, delimited}], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_request do
                   {:rtt_response, previous_value} ->
                     {:streaming_request,
                      {:rtt_response,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.RoundTripMeasurementResponse.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_request,
                      {:rtt_response,
                       Speechly.Slu.V1.RoundTripMeasurementResponse.decode!(delimited)}}
                 end
               ], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_request do
                   {:start, previous_value} ->
                     {:streaming_request,
                      {:start,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUStart.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_request, {:start, Speechly.Slu.V1.SLUStart.decode!(delimited)}}
                 end
               ], rest}

            {6, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_request do
                   {:stop, previous_value} ->
                     {:streaming_request,
                      {:stop,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUStop.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_request, {:stop, Speechly.Slu.V1.SLUStop.decode!(delimited)}}
                 end
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
        Speechly.Slu.V1.SLURequest,
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
        1 => {:config, {:oneof, :streaming_request}, {:message, Speechly.Slu.V1.SLUConfig}},
        2 => {:event, {:oneof, :streaming_request}, {:message, Speechly.Slu.V1.SLUEvent}},
        3 => {:audio, {:oneof, :streaming_request}, :bytes},
        4 =>
          {:rtt_response, {:oneof, :streaming_request},
           {:message, Speechly.Slu.V1.RoundTripMeasurementResponse}},
        5 => {:start, {:oneof, :streaming_request}, {:message, Speechly.Slu.V1.SLUStart}},
        6 => {:stop, {:oneof, :streaming_request}, {:message, Speechly.Slu.V1.SLUStop}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        audio: {3, {:oneof, :streaming_request}, :bytes},
        config: {1, {:oneof, :streaming_request}, {:message, Speechly.Slu.V1.SLUConfig}},
        event: {2, {:oneof, :streaming_request}, {:message, Speechly.Slu.V1.SLUEvent}},
        rtt_response:
          {4, {:oneof, :streaming_request},
           {:message, Speechly.Slu.V1.RoundTripMeasurementResponse}},
        start: {5, {:oneof, :streaming_request}, {:message, Speechly.Slu.V1.SLUStart}},
        stop: {6, {:oneof, :streaming_request}, {:message, Speechly.Slu.V1.SLUStop}}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "config",
          kind: {:oneof, :streaming_request},
          label: :optional,
          name: :config,
          tag: 1,
          type: {:message, Speechly.Slu.V1.SLUConfig}
        },
        %{
          __struct__: Protox.Field,
          json_name: "event",
          kind: {:oneof, :streaming_request},
          label: :optional,
          name: :event,
          tag: 2,
          type: {:message, Speechly.Slu.V1.SLUEvent}
        },
        %{
          __struct__: Protox.Field,
          json_name: "audio",
          kind: {:oneof, :streaming_request},
          label: :optional,
          name: :audio,
          tag: 3,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "rttResponse",
          kind: {:oneof, :streaming_request},
          label: :optional,
          name: :rtt_response,
          tag: 4,
          type: {:message, Speechly.Slu.V1.RoundTripMeasurementResponse}
        },
        %{
          __struct__: Protox.Field,
          json_name: "start",
          kind: {:oneof, :streaming_request},
          label: :optional,
          name: :start,
          tag: 5,
          type: {:message, Speechly.Slu.V1.SLUStart}
        },
        %{
          __struct__: Protox.Field,
          json_name: "stop",
          kind: {:oneof, :streaming_request},
          label: :optional,
          name: :stop,
          tag: 6,
          type: {:message, Speechly.Slu.V1.SLUStop}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:config) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "config",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :config,
             tag: 1,
             type: {:message, Speechly.Slu.V1.SLUConfig}
           }}
        end

        def field_def("config") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "config",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :config,
             tag: 1,
             type: {:message, Speechly.Slu.V1.SLUConfig}
           }}
        end

        []
      ),
      (
        def field_def(:event) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "event",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :event,
             tag: 2,
             type: {:message, Speechly.Slu.V1.SLUEvent}
           }}
        end

        def field_def("event") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "event",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :event,
             tag: 2,
             type: {:message, Speechly.Slu.V1.SLUEvent}
           }}
        end

        []
      ),
      (
        def field_def(:audio) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "audio",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :audio,
             tag: 3,
             type: :bytes
           }}
        end

        def field_def("audio") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "audio",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :audio,
             tag: 3,
             type: :bytes
           }}
        end

        []
      ),
      (
        def field_def(:rtt_response) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rttResponse",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :rtt_response,
             tag: 4,
             type: {:message, Speechly.Slu.V1.RoundTripMeasurementResponse}
           }}
        end

        def field_def("rttResponse") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rttResponse",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :rtt_response,
             tag: 4,
             type: {:message, Speechly.Slu.V1.RoundTripMeasurementResponse}
           }}
        end

        def field_def("rtt_response") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rttResponse",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :rtt_response,
             tag: 4,
             type: {:message, Speechly.Slu.V1.RoundTripMeasurementResponse}
           }}
        end
      ),
      (
        def field_def(:start) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "start",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :start,
             tag: 5,
             type: {:message, Speechly.Slu.V1.SLUStart}
           }}
        end

        def field_def("start") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "start",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :start,
             tag: 5,
             type: {:message, Speechly.Slu.V1.SLUStart}
           }}
        end

        []
      ),
      (
        def field_def(:stop) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "stop",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :stop,
             tag: 6,
             type: {:message, Speechly.Slu.V1.SLUStop}
           }}
        end

        def field_def("stop") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "stop",
             kind: {:oneof, :streaming_request},
             label: :optional,
             name: :stop,
             tag: 6,
             type: {:message, Speechly.Slu.V1.SLUStop}
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
    def default(:config) do
      {:error, :no_default_value}
    end,
    def default(:event) do
      {:error, :no_default_value}
    end,
    def default(:audio) do
      {:error, :no_default_value}
    end,
    def default(:rtt_response) do
      {:error, :no_default_value}
    end,
    def default(:start) do
      {:error, :no_default_value}
    end,
    def default(:stop) do
      {:error, :no_default_value}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

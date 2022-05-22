# credo:disable-for-this-file
defmodule Speechly.Slu.V1.SLUResponse do
  @moduledoc false
  defstruct audio_context: "", segment_id: 0, streaming_response: nil, __uf__: []

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
        |> encode_streaming_response(msg)
        |> encode_audio_context(msg)
        |> encode_segment_id(msg)
        |> encode_unknown_fields(msg)
      end
    )

    [
      defp encode_streaming_response(acc, msg) do
        case msg.streaming_response do
          nil -> acc
          {:transcript, _field_value} -> encode_transcript(acc, msg)
          {:entity, _field_value} -> encode_entity(acc, msg)
          {:intent, _field_value} -> encode_intent(acc, msg)
          {:segment_end, _field_value} -> encode_segment_end(acc, msg)
          {:tentative_transcript, _field_value} -> encode_tentative_transcript(acc, msg)
          {:tentative_entities, _field_value} -> encode_tentative_entities(acc, msg)
          {:tentative_intent, _field_value} -> encode_tentative_intent(acc, msg)
          {:started, _field_value} -> encode_started(acc, msg)
          {:finished, _field_value} -> encode_finished(acc, msg)
          {:rtt_request, _field_value} -> encode_rtt_request(acc, msg)
        end
      end
    ]

    [
      defp encode_audio_context(acc, msg) do
        try do
          if msg.audio_context == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_string(msg.audio_context)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:audio_context, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_segment_id(acc, msg) do
        try do
          if msg.segment_id == 0 do
            acc
          else
            [acc, "\x10", Protox.Encode.encode_int32(msg.segment_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:segment_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_transcript(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "\x1A", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:transcript, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_entity(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "\"", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:entity, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_intent(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "*", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:intent, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_segment_end(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "2", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:segment_end, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_tentative_transcript(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, ":", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:tentative_transcript, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_tentative_entities(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "B", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:tentative_entities, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_tentative_intent(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "J", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:tentative_intent, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_started(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "R", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:started, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_finished(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "Z", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:finished, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_rtt_request(acc, msg) do
        try do
          {_, child_field_value} = msg.streaming_response
          [acc, "b", Protox.Encode.encode_message(child_field_value)]
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:rtt_request, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Speechly.Slu.V1.SLUResponse))
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
              {[audio_context: delimited], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[segment_id: value], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:transcript, previous_value} ->
                     {:streaming_response,
                      {:transcript,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUTranscript.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:transcript, Speechly.Slu.V1.SLUTranscript.decode!(delimited)}}
                 end
               ], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:entity, previous_value} ->
                     {:streaming_response,
                      {:entity,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUEntity.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:entity, Speechly.Slu.V1.SLUEntity.decode!(delimited)}}
                 end
               ], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:intent, previous_value} ->
                     {:streaming_response,
                      {:intent,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUIntent.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:intent, Speechly.Slu.V1.SLUIntent.decode!(delimited)}}
                 end
               ], rest}

            {6, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:segment_end, previous_value} ->
                     {:streaming_response,
                      {:segment_end,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUSegmentEnd.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:segment_end, Speechly.Slu.V1.SLUSegmentEnd.decode!(delimited)}}
                 end
               ], rest}

            {7, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:tentative_transcript, previous_value} ->
                     {:streaming_response,
                      {:tentative_transcript,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUTentativeTranscript.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:tentative_transcript,
                       Speechly.Slu.V1.SLUTentativeTranscript.decode!(delimited)}}
                 end
               ], rest}

            {8, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:tentative_entities, previous_value} ->
                     {:streaming_response,
                      {:tentative_entities,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUTentativeEntities.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:tentative_entities,
                       Speechly.Slu.V1.SLUTentativeEntities.decode!(delimited)}}
                 end
               ], rest}

            {9, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:tentative_intent, previous_value} ->
                     {:streaming_response,
                      {:tentative_intent,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUIntent.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:tentative_intent, Speechly.Slu.V1.SLUIntent.decode!(delimited)}}
                 end
               ], rest}

            {10, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:started, previous_value} ->
                     {:streaming_response,
                      {:started,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUStarted.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:started, Speechly.Slu.V1.SLUStarted.decode!(delimited)}}
                 end
               ], rest}

            {11, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:finished, previous_value} ->
                     {:streaming_response,
                      {:finished,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.SLUFinished.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:finished, Speechly.Slu.V1.SLUFinished.decode!(delimited)}}
                 end
               ], rest}

            {12, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 case msg.streaming_response do
                   {:rtt_request, previous_value} ->
                     {:streaming_response,
                      {:rtt_request,
                       Protox.MergeMessage.merge(
                         previous_value,
                         Speechly.Slu.V1.RoundTripMeasurementRequest.decode!(delimited)
                       )}}

                   _ ->
                     {:streaming_response,
                      {:rtt_request,
                       Speechly.Slu.V1.RoundTripMeasurementRequest.decode!(delimited)}}
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
        Speechly.Slu.V1.SLUResponse,
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
        1 => {:audio_context, {:scalar, ""}, :string},
        2 => {:segment_id, {:scalar, 0}, :int32},
        3 =>
          {:transcript, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUTranscript}},
        4 => {:entity, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUEntity}},
        5 => {:intent, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUIntent}},
        6 =>
          {:segment_end, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUSegmentEnd}},
        7 =>
          {:tentative_transcript, {:oneof, :streaming_response},
           {:message, Speechly.Slu.V1.SLUTentativeTranscript}},
        8 =>
          {:tentative_entities, {:oneof, :streaming_response},
           {:message, Speechly.Slu.V1.SLUTentativeEntities}},
        9 =>
          {:tentative_intent, {:oneof, :streaming_response},
           {:message, Speechly.Slu.V1.SLUIntent}},
        10 => {:started, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUStarted}},
        11 => {:finished, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUFinished}},
        12 =>
          {:rtt_request, {:oneof, :streaming_response},
           {:message, Speechly.Slu.V1.RoundTripMeasurementRequest}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        audio_context: {1, {:scalar, ""}, :string},
        entity: {4, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUEntity}},
        finished: {11, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUFinished}},
        intent: {5, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUIntent}},
        rtt_request:
          {12, {:oneof, :streaming_response},
           {:message, Speechly.Slu.V1.RoundTripMeasurementRequest}},
        segment_end:
          {6, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUSegmentEnd}},
        segment_id: {2, {:scalar, 0}, :int32},
        started: {10, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUStarted}},
        tentative_entities:
          {8, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUTentativeEntities}},
        tentative_intent:
          {9, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUIntent}},
        tentative_transcript:
          {7, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUTentativeTranscript}},
        transcript: {3, {:oneof, :streaming_response}, {:message, Speechly.Slu.V1.SLUTranscript}}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "audioContext",
          kind: {:scalar, ""},
          label: :optional,
          name: :audio_context,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "segmentId",
          kind: {:scalar, 0},
          label: :optional,
          name: :segment_id,
          tag: 2,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "transcript",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :transcript,
          tag: 3,
          type: {:message, Speechly.Slu.V1.SLUTranscript}
        },
        %{
          __struct__: Protox.Field,
          json_name: "entity",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :entity,
          tag: 4,
          type: {:message, Speechly.Slu.V1.SLUEntity}
        },
        %{
          __struct__: Protox.Field,
          json_name: "intent",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :intent,
          tag: 5,
          type: {:message, Speechly.Slu.V1.SLUIntent}
        },
        %{
          __struct__: Protox.Field,
          json_name: "segmentEnd",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :segment_end,
          tag: 6,
          type: {:message, Speechly.Slu.V1.SLUSegmentEnd}
        },
        %{
          __struct__: Protox.Field,
          json_name: "tentativeTranscript",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :tentative_transcript,
          tag: 7,
          type: {:message, Speechly.Slu.V1.SLUTentativeTranscript}
        },
        %{
          __struct__: Protox.Field,
          json_name: "tentativeEntities",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :tentative_entities,
          tag: 8,
          type: {:message, Speechly.Slu.V1.SLUTentativeEntities}
        },
        %{
          __struct__: Protox.Field,
          json_name: "tentativeIntent",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :tentative_intent,
          tag: 9,
          type: {:message, Speechly.Slu.V1.SLUIntent}
        },
        %{
          __struct__: Protox.Field,
          json_name: "started",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :started,
          tag: 10,
          type: {:message, Speechly.Slu.V1.SLUStarted}
        },
        %{
          __struct__: Protox.Field,
          json_name: "finished",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :finished,
          tag: 11,
          type: {:message, Speechly.Slu.V1.SLUFinished}
        },
        %{
          __struct__: Protox.Field,
          json_name: "rttRequest",
          kind: {:oneof, :streaming_response},
          label: :optional,
          name: :rtt_request,
          tag: 12,
          type: {:message, Speechly.Slu.V1.RoundTripMeasurementRequest}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:audio_context) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "audioContext",
             kind: {:scalar, ""},
             label: :optional,
             name: :audio_context,
             tag: 1,
             type: :string
           }}
        end

        def field_def("audioContext") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "audioContext",
             kind: {:scalar, ""},
             label: :optional,
             name: :audio_context,
             tag: 1,
             type: :string
           }}
        end

        def field_def("audio_context") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "audioContext",
             kind: {:scalar, ""},
             label: :optional,
             name: :audio_context,
             tag: 1,
             type: :string
           }}
        end
      ),
      (
        def field_def(:segment_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "segmentId",
             kind: {:scalar, 0},
             label: :optional,
             name: :segment_id,
             tag: 2,
             type: :int32
           }}
        end

        def field_def("segmentId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "segmentId",
             kind: {:scalar, 0},
             label: :optional,
             name: :segment_id,
             tag: 2,
             type: :int32
           }}
        end

        def field_def("segment_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "segmentId",
             kind: {:scalar, 0},
             label: :optional,
             name: :segment_id,
             tag: 2,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:transcript) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "transcript",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :transcript,
             tag: 3,
             type: {:message, Speechly.Slu.V1.SLUTranscript}
           }}
        end

        def field_def("transcript") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "transcript",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :transcript,
             tag: 3,
             type: {:message, Speechly.Slu.V1.SLUTranscript}
           }}
        end

        []
      ),
      (
        def field_def(:entity) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "entity",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :entity,
             tag: 4,
             type: {:message, Speechly.Slu.V1.SLUEntity}
           }}
        end

        def field_def("entity") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "entity",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :entity,
             tag: 4,
             type: {:message, Speechly.Slu.V1.SLUEntity}
           }}
        end

        []
      ),
      (
        def field_def(:intent) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "intent",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :intent,
             tag: 5,
             type: {:message, Speechly.Slu.V1.SLUIntent}
           }}
        end

        def field_def("intent") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "intent",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :intent,
             tag: 5,
             type: {:message, Speechly.Slu.V1.SLUIntent}
           }}
        end

        []
      ),
      (
        def field_def(:segment_end) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "segmentEnd",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :segment_end,
             tag: 6,
             type: {:message, Speechly.Slu.V1.SLUSegmentEnd}
           }}
        end

        def field_def("segmentEnd") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "segmentEnd",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :segment_end,
             tag: 6,
             type: {:message, Speechly.Slu.V1.SLUSegmentEnd}
           }}
        end

        def field_def("segment_end") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "segmentEnd",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :segment_end,
             tag: 6,
             type: {:message, Speechly.Slu.V1.SLUSegmentEnd}
           }}
        end
      ),
      (
        def field_def(:tentative_transcript) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeTranscript",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_transcript,
             tag: 7,
             type: {:message, Speechly.Slu.V1.SLUTentativeTranscript}
           }}
        end

        def field_def("tentativeTranscript") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeTranscript",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_transcript,
             tag: 7,
             type: {:message, Speechly.Slu.V1.SLUTentativeTranscript}
           }}
        end

        def field_def("tentative_transcript") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeTranscript",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_transcript,
             tag: 7,
             type: {:message, Speechly.Slu.V1.SLUTentativeTranscript}
           }}
        end
      ),
      (
        def field_def(:tentative_entities) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeEntities",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_entities,
             tag: 8,
             type: {:message, Speechly.Slu.V1.SLUTentativeEntities}
           }}
        end

        def field_def("tentativeEntities") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeEntities",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_entities,
             tag: 8,
             type: {:message, Speechly.Slu.V1.SLUTentativeEntities}
           }}
        end

        def field_def("tentative_entities") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeEntities",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_entities,
             tag: 8,
             type: {:message, Speechly.Slu.V1.SLUTentativeEntities}
           }}
        end
      ),
      (
        def field_def(:tentative_intent) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeIntent",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_intent,
             tag: 9,
             type: {:message, Speechly.Slu.V1.SLUIntent}
           }}
        end

        def field_def("tentativeIntent") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeIntent",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_intent,
             tag: 9,
             type: {:message, Speechly.Slu.V1.SLUIntent}
           }}
        end

        def field_def("tentative_intent") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tentativeIntent",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :tentative_intent,
             tag: 9,
             type: {:message, Speechly.Slu.V1.SLUIntent}
           }}
        end
      ),
      (
        def field_def(:started) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "started",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :started,
             tag: 10,
             type: {:message, Speechly.Slu.V1.SLUStarted}
           }}
        end

        def field_def("started") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "started",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :started,
             tag: 10,
             type: {:message, Speechly.Slu.V1.SLUStarted}
           }}
        end

        []
      ),
      (
        def field_def(:finished) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "finished",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :finished,
             tag: 11,
             type: {:message, Speechly.Slu.V1.SLUFinished}
           }}
        end

        def field_def("finished") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "finished",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :finished,
             tag: 11,
             type: {:message, Speechly.Slu.V1.SLUFinished}
           }}
        end

        []
      ),
      (
        def field_def(:rtt_request) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rttRequest",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :rtt_request,
             tag: 12,
             type: {:message, Speechly.Slu.V1.RoundTripMeasurementRequest}
           }}
        end

        def field_def("rttRequest") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rttRequest",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :rtt_request,
             tag: 12,
             type: {:message, Speechly.Slu.V1.RoundTripMeasurementRequest}
           }}
        end

        def field_def("rtt_request") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rttRequest",
             kind: {:oneof, :streaming_response},
             label: :optional,
             name: :rtt_request,
             tag: 12,
             type: {:message, Speechly.Slu.V1.RoundTripMeasurementRequest}
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
    def default(:audio_context) do
      {:ok, ""}
    end,
    def default(:segment_id) do
      {:ok, 0}
    end,
    def default(:transcript) do
      {:error, :no_default_value}
    end,
    def default(:entity) do
      {:error, :no_default_value}
    end,
    def default(:intent) do
      {:error, :no_default_value}
    end,
    def default(:segment_end) do
      {:error, :no_default_value}
    end,
    def default(:tentative_transcript) do
      {:error, :no_default_value}
    end,
    def default(:tentative_entities) do
      {:error, :no_default_value}
    end,
    def default(:tentative_intent) do
      {:error, :no_default_value}
    end,
    def default(:started) do
      {:error, :no_default_value}
    end,
    def default(:finished) do
      {:error, :no_default_value}
    end,
    def default(:rtt_request) do
      {:error, :no_default_value}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

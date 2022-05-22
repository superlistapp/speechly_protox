# credo:disable-for-this-file
defmodule Speechly.Slu.V1.WLUSegment do
  @moduledoc false
  defstruct text: "", tokens: [], entities: [], intent: nil, annotated_text: "", __uf__: []

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
        |> encode_text(msg)
        |> encode_tokens(msg)
        |> encode_entities(msg)
        |> encode_intent(msg)
        |> encode_annotated_text(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_text(acc, msg) do
        try do
          if msg.text == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_string(msg.text)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:text, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_tokens(acc, msg) do
        try do
          case msg.tokens do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "\x12", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:tokens, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_entities(acc, msg) do
        try do
          case msg.entities do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "\x1A", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:entities, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_intent(acc, msg) do
        try do
          if msg.intent == nil do
            acc
          else
            [acc, "\"", Protox.Encode.encode_message(msg.intent)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:intent, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_annotated_text(acc, msg) do
        try do
          if msg.annotated_text == "" do
            acc
          else
            [acc, "*", Protox.Encode.encode_string(msg.annotated_text)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:annotated_text, "invalid field value"),
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
          parse_key_value(bytes, struct(Speechly.Slu.V1.WLUSegment))
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
              {[text: delimited], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[tokens: msg.tokens ++ [Speechly.Slu.V1.WLUToken.decode!(delimited)]], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[entities: msg.entities ++ [Speechly.Slu.V1.WLUEntity.decode!(delimited)]], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 intent:
                   Protox.MergeMessage.merge(
                     msg.intent,
                     Speechly.Slu.V1.WLUIntent.decode!(delimited)
                   )
               ], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[annotated_text: delimited], rest}

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
        Speechly.Slu.V1.WLUSegment,
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
        1 => {:text, {:scalar, ""}, :string},
        2 => {:tokens, :unpacked, {:message, Speechly.Slu.V1.WLUToken}},
        3 => {:entities, :unpacked, {:message, Speechly.Slu.V1.WLUEntity}},
        4 => {:intent, {:scalar, nil}, {:message, Speechly.Slu.V1.WLUIntent}},
        5 => {:annotated_text, {:scalar, ""}, :string}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        annotated_text: {5, {:scalar, ""}, :string},
        entities: {3, :unpacked, {:message, Speechly.Slu.V1.WLUEntity}},
        intent: {4, {:scalar, nil}, {:message, Speechly.Slu.V1.WLUIntent}},
        text: {1, {:scalar, ""}, :string},
        tokens: {2, :unpacked, {:message, Speechly.Slu.V1.WLUToken}}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "text",
          kind: {:scalar, ""},
          label: :optional,
          name: :text,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "tokens",
          kind: :unpacked,
          label: :repeated,
          name: :tokens,
          tag: 2,
          type: {:message, Speechly.Slu.V1.WLUToken}
        },
        %{
          __struct__: Protox.Field,
          json_name: "entities",
          kind: :unpacked,
          label: :repeated,
          name: :entities,
          tag: 3,
          type: {:message, Speechly.Slu.V1.WLUEntity}
        },
        %{
          __struct__: Protox.Field,
          json_name: "intent",
          kind: {:scalar, nil},
          label: :optional,
          name: :intent,
          tag: 4,
          type: {:message, Speechly.Slu.V1.WLUIntent}
        },
        %{
          __struct__: Protox.Field,
          json_name: "annotatedText",
          kind: {:scalar, ""},
          label: :optional,
          name: :annotated_text,
          tag: 5,
          type: :string
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:text) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "text",
             kind: {:scalar, ""},
             label: :optional,
             name: :text,
             tag: 1,
             type: :string
           }}
        end

        def field_def("text") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "text",
             kind: {:scalar, ""},
             label: :optional,
             name: :text,
             tag: 1,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:tokens) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tokens",
             kind: :unpacked,
             label: :repeated,
             name: :tokens,
             tag: 2,
             type: {:message, Speechly.Slu.V1.WLUToken}
           }}
        end

        def field_def("tokens") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tokens",
             kind: :unpacked,
             label: :repeated,
             name: :tokens,
             tag: 2,
             type: {:message, Speechly.Slu.V1.WLUToken}
           }}
        end

        []
      ),
      (
        def field_def(:entities) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "entities",
             kind: :unpacked,
             label: :repeated,
             name: :entities,
             tag: 3,
             type: {:message, Speechly.Slu.V1.WLUEntity}
           }}
        end

        def field_def("entities") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "entities",
             kind: :unpacked,
             label: :repeated,
             name: :entities,
             tag: 3,
             type: {:message, Speechly.Slu.V1.WLUEntity}
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
             kind: {:scalar, nil},
             label: :optional,
             name: :intent,
             tag: 4,
             type: {:message, Speechly.Slu.V1.WLUIntent}
           }}
        end

        def field_def("intent") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "intent",
             kind: {:scalar, nil},
             label: :optional,
             name: :intent,
             tag: 4,
             type: {:message, Speechly.Slu.V1.WLUIntent}
           }}
        end

        []
      ),
      (
        def field_def(:annotated_text) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "annotatedText",
             kind: {:scalar, ""},
             label: :optional,
             name: :annotated_text,
             tag: 5,
             type: :string
           }}
        end

        def field_def("annotatedText") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "annotatedText",
             kind: {:scalar, ""},
             label: :optional,
             name: :annotated_text,
             tag: 5,
             type: :string
           }}
        end

        def field_def("annotated_text") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "annotatedText",
             kind: {:scalar, ""},
             label: :optional,
             name: :annotated_text,
             tag: 5,
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
    def default(:text) do
      {:ok, ""}
    end,
    def default(:tokens) do
      {:error, :no_default_value}
    end,
    def default(:entities) do
      {:error, :no_default_value}
    end,
    def default(:intent) do
      {:ok, nil}
    end,
    def default(:annotated_text) do
      {:ok, ""}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

# credo:disable-for-this-file
defmodule Speechly.Sal.V1.LineReference do
  @moduledoc false
  defstruct line: 0, column: 0, file: "", level: :LEVEL_NOTE, message: "", __uf__: []

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
        |> encode_line(msg)
        |> encode_column(msg)
        |> encode_file(msg)
        |> encode_level(msg)
        |> encode_message(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_line(acc, msg) do
        try do
          if msg.line == 0 do
            acc
          else
            [acc, "\b", Protox.Encode.encode_uint64(msg.line)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:line, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_column(acc, msg) do
        try do
          if msg.column == 0 do
            acc
          else
            [acc, "\x10", Protox.Encode.encode_uint32(msg.column)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:column, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_file(acc, msg) do
        try do
          if msg.file == "" do
            acc
          else
            [acc, "\x1A", Protox.Encode.encode_string(msg.file)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:file, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_level(acc, msg) do
        try do
          if msg.level == :LEVEL_NOTE do
            acc
          else
            [
              acc,
              " ",
              msg.level
              |> Speechly.Sal.V1.LineReference.Level.encode()
              |> Protox.Encode.encode_enum()
            ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:level, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_message(acc, msg) do
        try do
          if msg.message == "" do
            acc
          else
            [acc, "*", Protox.Encode.encode_string(msg.message)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:message, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(Speechly.Sal.V1.LineReference))
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
              {value, rest} = Protox.Decode.parse_uint64(bytes)
              {[line: value], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_uint32(bytes)
              {[column: value], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[file: delimited], rest}

            {4, _, bytes} ->
              {value, rest} = Protox.Decode.parse_enum(bytes, Speechly.Sal.V1.LineReference.Level)
              {[level: value], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[message: delimited], rest}

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
        Speechly.Sal.V1.LineReference,
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
        1 => {:line, {:scalar, 0}, :uint64},
        2 => {:column, {:scalar, 0}, :uint32},
        3 => {:file, {:scalar, ""}, :string},
        4 => {:level, {:scalar, :LEVEL_NOTE}, {:enum, Speechly.Sal.V1.LineReference.Level}},
        5 => {:message, {:scalar, ""}, :string}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        column: {2, {:scalar, 0}, :uint32},
        file: {3, {:scalar, ""}, :string},
        level: {4, {:scalar, :LEVEL_NOTE}, {:enum, Speechly.Sal.V1.LineReference.Level}},
        line: {1, {:scalar, 0}, :uint64},
        message: {5, {:scalar, ""}, :string}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "line",
          kind: {:scalar, 0},
          label: :optional,
          name: :line,
          tag: 1,
          type: :uint64
        },
        %{
          __struct__: Protox.Field,
          json_name: "column",
          kind: {:scalar, 0},
          label: :optional,
          name: :column,
          tag: 2,
          type: :uint32
        },
        %{
          __struct__: Protox.Field,
          json_name: "file",
          kind: {:scalar, ""},
          label: :optional,
          name: :file,
          tag: 3,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "level",
          kind: {:scalar, :LEVEL_NOTE},
          label: :optional,
          name: :level,
          tag: 4,
          type: {:enum, Speechly.Sal.V1.LineReference.Level}
        },
        %{
          __struct__: Protox.Field,
          json_name: "message",
          kind: {:scalar, ""},
          label: :optional,
          name: :message,
          tag: 5,
          type: :string
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:line) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "line",
             kind: {:scalar, 0},
             label: :optional,
             name: :line,
             tag: 1,
             type: :uint64
           }}
        end

        def field_def("line") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "line",
             kind: {:scalar, 0},
             label: :optional,
             name: :line,
             tag: 1,
             type: :uint64
           }}
        end

        []
      ),
      (
        def field_def(:column) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "column",
             kind: {:scalar, 0},
             label: :optional,
             name: :column,
             tag: 2,
             type: :uint32
           }}
        end

        def field_def("column") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "column",
             kind: {:scalar, 0},
             label: :optional,
             name: :column,
             tag: 2,
             type: :uint32
           }}
        end

        []
      ),
      (
        def field_def(:file) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "file",
             kind: {:scalar, ""},
             label: :optional,
             name: :file,
             tag: 3,
             type: :string
           }}
        end

        def field_def("file") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "file",
             kind: {:scalar, ""},
             label: :optional,
             name: :file,
             tag: 3,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:level) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "level",
             kind: {:scalar, :LEVEL_NOTE},
             label: :optional,
             name: :level,
             tag: 4,
             type: {:enum, Speechly.Sal.V1.LineReference.Level}
           }}
        end

        def field_def("level") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "level",
             kind: {:scalar, :LEVEL_NOTE},
             label: :optional,
             name: :level,
             tag: 4,
             type: {:enum, Speechly.Sal.V1.LineReference.Level}
           }}
        end

        []
      ),
      (
        def field_def(:message) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "message",
             kind: {:scalar, ""},
             label: :optional,
             name: :message,
             tag: 5,
             type: :string
           }}
        end

        def field_def("message") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "message",
             kind: {:scalar, ""},
             label: :optional,
             name: :message,
             tag: 5,
             type: :string
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
    def default(:line) do
      {:ok, 0}
    end,
    def default(:column) do
      {:ok, 0}
    end,
    def default(:file) do
      {:ok, ""}
    end,
    def default(:level) do
      {:ok, :LEVEL_NOTE}
    end,
    def default(:message) do
      {:ok, ""}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

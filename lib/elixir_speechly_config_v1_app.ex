# credo:disable-for-this-file
defmodule Speechly.Config.V1.App do
  @moduledoc false
  defstruct id: "",
            language: "",
            status: :STATUS_UNSPECIFIED,
            name: "",
            queue_size: 0,
            error_msg: "",
            estimated_remaining_sec: 0,
            estimated_training_time_sec: 0,
            training_time_sec: 0,
            tags: [],
            deployed_at_time: nil,
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
        |> encode_id(msg)
        |> encode_language(msg)
        |> encode_status(msg)
        |> encode_name(msg)
        |> encode_queue_size(msg)
        |> encode_error_msg(msg)
        |> encode_estimated_remaining_sec(msg)
        |> encode_estimated_training_time_sec(msg)
        |> encode_training_time_sec(msg)
        |> encode_tags(msg)
        |> encode_deployed_at_time(msg)
        |> encode_unknown_fields(msg)
      end
    )

    []

    [
      defp encode_id(acc, msg) do
        try do
          if msg.id == "" do
            acc
          else
            [acc, "\n", Protox.Encode.encode_string(msg.id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_language(acc, msg) do
        try do
          if msg.language == "" do
            acc
          else
            [acc, "\x12", Protox.Encode.encode_string(msg.language)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:language, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_status(acc, msg) do
        try do
          if msg.status == :STATUS_UNSPECIFIED do
            acc
          else
            [
              acc,
              "\x18",
              msg.status |> Speechly.Config.V1.App.Status.encode() |> Protox.Encode.encode_enum()
            ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:status, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_name(acc, msg) do
        try do
          if msg.name == "" do
            acc
          else
            [acc, "\"", Protox.Encode.encode_string(msg.name)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:name, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_queue_size(acc, msg) do
        try do
          if msg.queue_size == 0 do
            acc
          else
            [acc, "(", Protox.Encode.encode_int32(msg.queue_size)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:queue_size, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_error_msg(acc, msg) do
        try do
          if msg.error_msg == "" do
            acc
          else
            [acc, "2", Protox.Encode.encode_string(msg.error_msg)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:error_msg, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_estimated_remaining_sec(acc, msg) do
        try do
          if msg.estimated_remaining_sec == 0 do
            acc
          else
            [acc, "8", Protox.Encode.encode_int32(msg.estimated_remaining_sec)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:estimated_remaining_sec, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_estimated_training_time_sec(acc, msg) do
        try do
          if msg.estimated_training_time_sec == 0 do
            acc
          else
            [acc, "@", Protox.Encode.encode_int32(msg.estimated_training_time_sec)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:estimated_training_time_sec, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_training_time_sec(acc, msg) do
        try do
          if msg.training_time_sec == 0 do
            acc
          else
            [acc, "H", Protox.Encode.encode_int32(msg.training_time_sec)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:training_time_sec, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_tags(acc, msg) do
        try do
          case msg.tags do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "R", Protox.Encode.encode_string(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:tags, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_deployed_at_time(acc, msg) do
        try do
          if msg.deployed_at_time == nil do
            acc
          else
            [acc, "Z", Protox.Encode.encode_message(msg.deployed_at_time)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:deployed_at_time, "invalid field value"),
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
          parse_key_value(bytes, struct(Speechly.Config.V1.App))
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
              {[id: delimited], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[language: delimited], rest}

            {3, _, bytes} ->
              {value, rest} = Protox.Decode.parse_enum(bytes, Speechly.Config.V1.App.Status)
              {[status: value], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[name: delimited], rest}

            {5, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[queue_size: value], rest}

            {6, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[error_msg: delimited], rest}

            {7, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[estimated_remaining_sec: value], rest}

            {8, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[estimated_training_time_sec: value], rest}

            {9, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[training_time_sec: value], rest}

            {10, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[tags: msg.tags ++ [delimited]], rest}

            {11, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 deployed_at_time:
                   Protox.MergeMessage.merge(
                     msg.deployed_at_time,
                     Google.Protobuf.Timestamp.decode!(delimited)
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
        Speechly.Config.V1.App,
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
        1 => {:id, {:scalar, ""}, :string},
        2 => {:language, {:scalar, ""}, :string},
        3 => {:status, {:scalar, :STATUS_UNSPECIFIED}, {:enum, Speechly.Config.V1.App.Status}},
        4 => {:name, {:scalar, ""}, :string},
        5 => {:queue_size, {:scalar, 0}, :int32},
        6 => {:error_msg, {:scalar, ""}, :string},
        7 => {:estimated_remaining_sec, {:scalar, 0}, :int32},
        8 => {:estimated_training_time_sec, {:scalar, 0}, :int32},
        9 => {:training_time_sec, {:scalar, 0}, :int32},
        10 => {:tags, :unpacked, :string},
        11 => {:deployed_at_time, {:scalar, nil}, {:message, Google.Protobuf.Timestamp}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        deployed_at_time: {11, {:scalar, nil}, {:message, Google.Protobuf.Timestamp}},
        error_msg: {6, {:scalar, ""}, :string},
        estimated_remaining_sec: {7, {:scalar, 0}, :int32},
        estimated_training_time_sec: {8, {:scalar, 0}, :int32},
        id: {1, {:scalar, ""}, :string},
        language: {2, {:scalar, ""}, :string},
        name: {4, {:scalar, ""}, :string},
        queue_size: {5, {:scalar, 0}, :int32},
        status: {3, {:scalar, :STATUS_UNSPECIFIED}, {:enum, Speechly.Config.V1.App.Status}},
        tags: {10, :unpacked, :string},
        training_time_sec: {9, {:scalar, 0}, :int32}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "id",
          kind: {:scalar, ""},
          label: :optional,
          name: :id,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "language",
          kind: {:scalar, ""},
          label: :optional,
          name: :language,
          tag: 2,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "status",
          kind: {:scalar, :STATUS_UNSPECIFIED},
          label: :optional,
          name: :status,
          tag: 3,
          type: {:enum, Speechly.Config.V1.App.Status}
        },
        %{
          __struct__: Protox.Field,
          json_name: "name",
          kind: {:scalar, ""},
          label: :optional,
          name: :name,
          tag: 4,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "queueSize",
          kind: {:scalar, 0},
          label: :optional,
          name: :queue_size,
          tag: 5,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "errorMsg",
          kind: {:scalar, ""},
          label: :optional,
          name: :error_msg,
          tag: 6,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "estimatedRemainingSec",
          kind: {:scalar, 0},
          label: :optional,
          name: :estimated_remaining_sec,
          tag: 7,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "estimatedTrainingTimeSec",
          kind: {:scalar, 0},
          label: :optional,
          name: :estimated_training_time_sec,
          tag: 8,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "trainingTimeSec",
          kind: {:scalar, 0},
          label: :optional,
          name: :training_time_sec,
          tag: 9,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "tags",
          kind: :unpacked,
          label: :repeated,
          name: :tags,
          tag: 10,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "deployedAtTime",
          kind: {:scalar, nil},
          label: :optional,
          name: :deployed_at_time,
          tag: 11,
          type: {:message, Google.Protobuf.Timestamp}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "id",
             kind: {:scalar, ""},
             label: :optional,
             name: :id,
             tag: 1,
             type: :string
           }}
        end

        def field_def("id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "id",
             kind: {:scalar, ""},
             label: :optional,
             name: :id,
             tag: 1,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:language) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "language",
             kind: {:scalar, ""},
             label: :optional,
             name: :language,
             tag: 2,
             type: :string
           }}
        end

        def field_def("language") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "language",
             kind: {:scalar, ""},
             label: :optional,
             name: :language,
             tag: 2,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:status) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "status",
             kind: {:scalar, :STATUS_UNSPECIFIED},
             label: :optional,
             name: :status,
             tag: 3,
             type: {:enum, Speechly.Config.V1.App.Status}
           }}
        end

        def field_def("status") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "status",
             kind: {:scalar, :STATUS_UNSPECIFIED},
             label: :optional,
             name: :status,
             tag: 3,
             type: {:enum, Speechly.Config.V1.App.Status}
           }}
        end

        []
      ),
      (
        def field_def(:name) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "name",
             kind: {:scalar, ""},
             label: :optional,
             name: :name,
             tag: 4,
             type: :string
           }}
        end

        def field_def("name") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "name",
             kind: {:scalar, ""},
             label: :optional,
             name: :name,
             tag: 4,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:queue_size) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "queueSize",
             kind: {:scalar, 0},
             label: :optional,
             name: :queue_size,
             tag: 5,
             type: :int32
           }}
        end

        def field_def("queueSize") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "queueSize",
             kind: {:scalar, 0},
             label: :optional,
             name: :queue_size,
             tag: 5,
             type: :int32
           }}
        end

        def field_def("queue_size") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "queueSize",
             kind: {:scalar, 0},
             label: :optional,
             name: :queue_size,
             tag: 5,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:error_msg) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "errorMsg",
             kind: {:scalar, ""},
             label: :optional,
             name: :error_msg,
             tag: 6,
             type: :string
           }}
        end

        def field_def("errorMsg") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "errorMsg",
             kind: {:scalar, ""},
             label: :optional,
             name: :error_msg,
             tag: 6,
             type: :string
           }}
        end

        def field_def("error_msg") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "errorMsg",
             kind: {:scalar, ""},
             label: :optional,
             name: :error_msg,
             tag: 6,
             type: :string
           }}
        end
      ),
      (
        def field_def(:estimated_remaining_sec) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "estimatedRemainingSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :estimated_remaining_sec,
             tag: 7,
             type: :int32
           }}
        end

        def field_def("estimatedRemainingSec") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "estimatedRemainingSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :estimated_remaining_sec,
             tag: 7,
             type: :int32
           }}
        end

        def field_def("estimated_remaining_sec") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "estimatedRemainingSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :estimated_remaining_sec,
             tag: 7,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:estimated_training_time_sec) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "estimatedTrainingTimeSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :estimated_training_time_sec,
             tag: 8,
             type: :int32
           }}
        end

        def field_def("estimatedTrainingTimeSec") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "estimatedTrainingTimeSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :estimated_training_time_sec,
             tag: 8,
             type: :int32
           }}
        end

        def field_def("estimated_training_time_sec") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "estimatedTrainingTimeSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :estimated_training_time_sec,
             tag: 8,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:training_time_sec) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "trainingTimeSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :training_time_sec,
             tag: 9,
             type: :int32
           }}
        end

        def field_def("trainingTimeSec") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "trainingTimeSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :training_time_sec,
             tag: 9,
             type: :int32
           }}
        end

        def field_def("training_time_sec") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "trainingTimeSec",
             kind: {:scalar, 0},
             label: :optional,
             name: :training_time_sec,
             tag: 9,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:tags) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tags",
             kind: :unpacked,
             label: :repeated,
             name: :tags,
             tag: 10,
             type: :string
           }}
        end

        def field_def("tags") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tags",
             kind: :unpacked,
             label: :repeated,
             name: :tags,
             tag: 10,
             type: :string
           }}
        end

        []
      ),
      (
        def field_def(:deployed_at_time) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "deployedAtTime",
             kind: {:scalar, nil},
             label: :optional,
             name: :deployed_at_time,
             tag: 11,
             type: {:message, Google.Protobuf.Timestamp}
           }}
        end

        def field_def("deployedAtTime") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "deployedAtTime",
             kind: {:scalar, nil},
             label: :optional,
             name: :deployed_at_time,
             tag: 11,
             type: {:message, Google.Protobuf.Timestamp}
           }}
        end

        def field_def("deployed_at_time") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "deployedAtTime",
             kind: {:scalar, nil},
             label: :optional,
             name: :deployed_at_time,
             tag: 11,
             type: {:message, Google.Protobuf.Timestamp}
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
    def default(:id) do
      {:ok, ""}
    end,
    def default(:language) do
      {:ok, ""}
    end,
    def default(:status) do
      {:ok, :STATUS_UNSPECIFIED}
    end,
    def default(:name) do
      {:ok, ""}
    end,
    def default(:queue_size) do
      {:ok, 0}
    end,
    def default(:error_msg) do
      {:ok, ""}
    end,
    def default(:estimated_remaining_sec) do
      {:ok, 0}
    end,
    def default(:estimated_training_time_sec) do
      {:ok, 0}
    end,
    def default(:training_time_sec) do
      {:ok, 0}
    end,
    def default(:tags) do
      {:error, :no_default_value}
    end,
    def default(:deployed_at_time) do
      {:ok, nil}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]
end

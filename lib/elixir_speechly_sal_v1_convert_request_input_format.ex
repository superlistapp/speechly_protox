# credo:disable-for-this-file
defmodule Speechly.Sal.V1.ConvertRequest.InputFormat do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :FORMAT_UNKNOWN
      def default() do
        :FORMAT_UNKNOWN
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:FORMAT_UNKNOWN) do
          0
        end

        def encode("FORMAT_UNKNOWN") do
          0
        end
      ),
      (
        def encode(:FORMAT_ALEXA) do
          1
        end

        def encode("FORMAT_ALEXA") do
          1
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :FORMAT_UNKNOWN
      end,
      def decode(1) do
        :FORMAT_ALEXA
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :FORMAT_UNKNOWN}, {1, :FORMAT_ALEXA}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:FORMAT_UNKNOWN) do
          true
        end,
        def has_constant?(:FORMAT_ALEXA) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

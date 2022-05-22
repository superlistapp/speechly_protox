# credo:disable-for-this-file
defmodule Speechly.Slu.V1.SLUEvent.Event do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :START
      def default() do
        :START
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:START) do
          0
        end

        def encode("START") do
          0
        end
      ),
      (
        def encode(:STOP) do
          1
        end

        def encode("STOP") do
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
        :START
      end,
      def decode(1) do
        :STOP
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :START}, {1, :STOP}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:START) do
          true
        end,
        def has_constant?(:STOP) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

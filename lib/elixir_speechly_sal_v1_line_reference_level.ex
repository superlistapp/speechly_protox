# credo:disable-for-this-file
defmodule Speechly.Sal.V1.LineReference.Level do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :LEVEL_NOTE
      def default() do
        :LEVEL_NOTE
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:LEVEL_NOTE) do
          0
        end

        def encode("LEVEL_NOTE") do
          0
        end
      ),
      (
        def encode(:LEVEL_WARNING) do
          1
        end

        def encode("LEVEL_WARNING") do
          1
        end
      ),
      (
        def encode(:LEVEL_ERROR) do
          2
        end

        def encode("LEVEL_ERROR") do
          2
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :LEVEL_NOTE
      end,
      def decode(1) do
        :LEVEL_WARNING
      end,
      def decode(2) do
        :LEVEL_ERROR
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :LEVEL_NOTE}, {1, :LEVEL_WARNING}, {2, :LEVEL_ERROR}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:LEVEL_NOTE) do
          true
        end,
        def has_constant?(:LEVEL_WARNING) do
          true
        end,
        def has_constant?(:LEVEL_ERROR) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

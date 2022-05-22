# credo:disable-for-this-file
defmodule Speechly.Analytics.V1.Aggregation do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :AGGREGATION_INVALID
      def default() do
        :AGGREGATION_INVALID
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:AGGREGATION_INVALID) do
          0
        end

        def encode("AGGREGATION_INVALID") do
          0
        end
      ),
      (
        def encode(:AGGREGATION_MONTHLY) do
          1
        end

        def encode("AGGREGATION_MONTHLY") do
          1
        end
      ),
      (
        def encode(:AGGREGATION_DAILY) do
          2
        end

        def encode("AGGREGATION_DAILY") do
          2
        end
      ),
      (
        def encode(:AGGREGATION_HOURLY) do
          3
        end

        def encode("AGGREGATION_HOURLY") do
          3
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :AGGREGATION_INVALID
      end,
      def decode(1) do
        :AGGREGATION_MONTHLY
      end,
      def decode(2) do
        :AGGREGATION_DAILY
      end,
      def decode(3) do
        :AGGREGATION_HOURLY
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [
        {0, :AGGREGATION_INVALID},
        {1, :AGGREGATION_MONTHLY},
        {2, :AGGREGATION_DAILY},
        {3, :AGGREGATION_HOURLY}
      ]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:AGGREGATION_INVALID) do
          true
        end,
        def has_constant?(:AGGREGATION_MONTHLY) do
          true
        end,
        def has_constant?(:AGGREGATION_DAILY) do
          true
        end,
        def has_constant?(:AGGREGATION_HOURLY) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

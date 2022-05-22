# credo:disable-for-this-file
defmodule Speechly.Sal.V1.ConvertResult.Status do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :CONVERT_SUCCESS
      def default() do
        :CONVERT_SUCCESS
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:CONVERT_SUCCESS) do
          0
        end

        def encode("CONVERT_SUCCESS") do
          0
        end
      ),
      (
        def encode(:CONVERT_WARNINGS) do
          1
        end

        def encode("CONVERT_WARNINGS") do
          1
        end
      ),
      (
        def encode(:CONVERT_FAILED) do
          2
        end

        def encode("CONVERT_FAILED") do
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
        :CONVERT_SUCCESS
      end,
      def decode(1) do
        :CONVERT_WARNINGS
      end,
      def decode(2) do
        :CONVERT_FAILED
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :CONVERT_SUCCESS}, {1, :CONVERT_WARNINGS}, {2, :CONVERT_FAILED}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:CONVERT_SUCCESS) do
          true
        end,
        def has_constant?(:CONVERT_WARNINGS) do
          true
        end,
        def has_constant?(:CONVERT_FAILED) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

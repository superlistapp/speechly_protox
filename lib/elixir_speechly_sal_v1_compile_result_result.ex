# credo:disable-for-this-file
defmodule Speechly.Sal.V1.CompileResult.Result do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :COMPILE_SUCCESS
      def default() do
        :COMPILE_SUCCESS
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:COMPILE_SUCCESS) do
          0
        end

        def encode("COMPILE_SUCCESS") do
          0
        end
      ),
      (
        def encode(:COMPILE_FAILURE) do
          1
        end

        def encode("COMPILE_FAILURE") do
          1
        end
      ),
      (
        def encode(:COMPILE_WARNING) do
          2
        end

        def encode("COMPILE_WARNING") do
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
        :COMPILE_SUCCESS
      end,
      def decode(1) do
        :COMPILE_FAILURE
      end,
      def decode(2) do
        :COMPILE_WARNING
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :COMPILE_SUCCESS}, {1, :COMPILE_FAILURE}, {2, :COMPILE_WARNING}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:COMPILE_SUCCESS) do
          true
        end,
        def has_constant?(:COMPILE_FAILURE) do
          true
        end,
        def has_constant?(:COMPILE_WARNING) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

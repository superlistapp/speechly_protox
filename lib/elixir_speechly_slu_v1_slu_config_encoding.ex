# credo:disable-for-this-file
defmodule Speechly.Slu.V1.SLUConfig.Encoding do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :LINEAR16
      def default() do
        :LINEAR16
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:LINEAR16) do
          0
        end

        def encode("LINEAR16") do
          0
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :LINEAR16
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :LINEAR16}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:LINEAR16) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

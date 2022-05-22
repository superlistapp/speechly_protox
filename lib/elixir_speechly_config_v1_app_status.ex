# credo:disable-for-this-file
defmodule Speechly.Config.V1.App.Status do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :STATUS_UNSPECIFIED
      def default() do
        :STATUS_UNSPECIFIED
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:STATUS_UNSPECIFIED) do
          0
        end

        def encode("STATUS_UNSPECIFIED") do
          0
        end
      ),
      (
        def encode(:STATUS_NEW) do
          1
        end

        def encode("STATUS_NEW") do
          1
        end
      ),
      (
        def encode(:STATUS_TRAINING) do
          2
        end

        def encode("STATUS_TRAINING") do
          2
        end
      ),
      (
        def encode(:STATUS_TRAINED) do
          3
        end

        def encode("STATUS_TRAINED") do
          3
        end
      ),
      (
        def encode(:STATUS_FAILED) do
          4
        end

        def encode("STATUS_FAILED") do
          4
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :STATUS_UNSPECIFIED
      end,
      def decode(1) do
        :STATUS_NEW
      end,
      def decode(2) do
        :STATUS_TRAINING
      end,
      def decode(3) do
        :STATUS_TRAINED
      end,
      def decode(4) do
        :STATUS_FAILED
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [
        {0, :STATUS_UNSPECIFIED},
        {1, :STATUS_NEW},
        {2, :STATUS_TRAINING},
        {3, :STATUS_TRAINED},
        {4, :STATUS_FAILED}
      ]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:STATUS_UNSPECIFIED) do
          true
        end,
        def has_constant?(:STATUS_NEW) do
          true
        end,
        def has_constant?(:STATUS_TRAINING) do
          true
        end,
        def has_constant?(:STATUS_TRAINED) do
          true
        end,
        def has_constant?(:STATUS_FAILED) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

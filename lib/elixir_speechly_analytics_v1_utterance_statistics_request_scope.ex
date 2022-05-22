# credo:disable-for-this-file
defmodule Speechly.Analytics.V1.UtteranceStatisticsRequest.Scope do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :SCOPE_INVALID
      def default() do
        :SCOPE_INVALID
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:SCOPE_INVALID) do
          0
        end

        def encode("SCOPE_INVALID") do
          0
        end
      ),
      (
        def encode(:SCOPE_UTTERANCES) do
          1
        end

        def encode("SCOPE_UTTERANCES") do
          1
        end
      ),
      (
        def encode(:SCOPE_ANNOTATIONS) do
          2
        end

        def encode("SCOPE_ANNOTATIONS") do
          2
        end
      ),
      (
        def encode(:SCOPE_ALL) do
          3
        end

        def encode("SCOPE_ALL") do
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
        :SCOPE_INVALID
      end,
      def decode(1) do
        :SCOPE_UTTERANCES
      end,
      def decode(2) do
        :SCOPE_ANNOTATIONS
      end,
      def decode(3) do
        :SCOPE_ALL
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :SCOPE_INVALID}, {1, :SCOPE_UTTERANCES}, {2, :SCOPE_ANNOTATIONS}, {3, :SCOPE_ALL}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:SCOPE_INVALID) do
          true
        end,
        def has_constant?(:SCOPE_UTTERANCES) do
          true
        end,
        def has_constant?(:SCOPE_ANNOTATIONS) do
          true
        end,
        def has_constant?(:SCOPE_ALL) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

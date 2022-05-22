# credo:disable-for-this-file
defmodule Speechly.Sal.V1.AppSource.ContentType do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :CONTENT_TYPE_UNSPECIFIED
      def default() do
        :CONTENT_TYPE_UNSPECIFIED
      end
    )

    @spec encode(atom()) :: integer() | atom()
    [
      (
        def encode(:CONTENT_TYPE_UNSPECIFIED) do
          0
        end

        def encode("CONTENT_TYPE_UNSPECIFIED") do
          0
        end
      ),
      (
        def encode(:CONTENT_TYPE_YAML) do
          1
        end

        def encode("CONTENT_TYPE_YAML") do
          1
        end
      ),
      (
        def encode(:CONTENT_TYPE_TAR) do
          2
        end

        def encode("CONTENT_TYPE_TAR") do
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
        :CONTENT_TYPE_UNSPECIFIED
      end,
      def decode(1) do
        :CONTENT_TYPE_YAML
      end,
      def decode(2) do
        :CONTENT_TYPE_TAR
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :CONTENT_TYPE_UNSPECIFIED}, {1, :CONTENT_TYPE_YAML}, {2, :CONTENT_TYPE_TAR}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:CONTENT_TYPE_UNSPECIFIED) do
          true
        end,
        def has_constant?(:CONTENT_TYPE_YAML) do
          true
        end,
        def has_constant?(:CONTENT_TYPE_TAR) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end

defmodule SpeechlyProtoxTest do
  use ExUnit.Case
  doctest SpeechlyProtox

  test "greets the world" do
    assert SpeechlyProtox.hello() == :world
  end
end

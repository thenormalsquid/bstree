defmodule BstTest do
  use ExUnit.Case
  doctest Bst

  test "the truth" do
    assert 1 + 1 == 2
  end

  test 'testem' do
    assert Bst.Node.testem == 'testem'
  end
end

defmodule ExChatChannel do
  use ExUnit.Case
  alias ExChat.{Channel, Message}

  setup do
    Channel.start()
    :ok
  end

  test "should handle join to channel properly" do
    Channel.join(:member_one)
    Channel.join(:member_two)
    assert MapSet.equal?(Channel.get_members, MapSet.new([:member_one, :member_two]))
  end

  test "should not add same member twice" do
    Channel.join(:member_one)
    Channel.join(:member_one)
    assert MapSet.equal?(Channel.get_members, MapSet.new([:member_one]))
  end

  test "should send only properly formatted messages" do
    assert_raise FunctionClauseError, fn ->
      Channel.send_message("some message")
    end
  end

end

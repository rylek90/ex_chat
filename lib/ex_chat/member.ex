defmodule ExChat.Member do
  use GenServer
  alias ExChat.{Message, Channel}

  def start(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def send_message(name, content) do
    GenServer.cast(name, {:send, content})
  end

  def receive_message(name, message = %Message{}) do
    GenServer.cast(name, {:receive, message})
  end

  def handle_cast({:receive, %Message{member: from, content: content}}, name) do
    IO.puts("#{name} Received new message! - [#{from}] - #{content}")
    {:noreply, name}
  end

  def handle_cast({:send, content}, name) do
    Channel.send_message(%Message{member: name, content: content})
    {:noreply, name}
  end
end

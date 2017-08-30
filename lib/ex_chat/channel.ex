defmodule ExChat.Channel do
  use GenServer
  alias ExChat.{Message, Member}

  def start do
    GenServer.start_link(__MODULE__, MapSet.new(), name: __MODULE__)
  end

  def init(members) do
    {:ok, members}
  end

  def get_members do
    GenServer.call(__MODULE__, :info)
  end

  def handle_call(:info, _from, members) do
    {:reply, members, members}
  end

  def send_message(message = %Message{}) do
    GenServer.cast(__MODULE__, {:send_message, message})
  end

  def join(name) do
    GenServer.cast(__MODULE__, {:join, name})
  end

  def handle_cast({:send_message, message = %Message{member: member}}, members) do
    MapSet.to_list(members)
    |> Enum.reject(fn(mem) -> member == mem end)
    |> Enum.each(fn (mem) -> Member.receive_message(mem, message) end)
    {:noreply, members}
  end

  def handle_cast({:join, name}, members) do
    {:noreply, MapSet.put(members, name)}
  end

end

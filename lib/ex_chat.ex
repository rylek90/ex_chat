defmodule ExChat do

  alias ExChat.{Channel, Member}

  def test do
    Channel.start()

    Member.start(:jan)
    Member.start(:pawel)

    Channel.join(:jan)
    Channel.join(:pawel)

    Member.send_message(:jan, "Jestem papiezem")
    Member.send_message(:pawel, "A nie, bo ja")

  end
end

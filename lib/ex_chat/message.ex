defmodule ExChat.Message do
  @enforce_keys [:content, :member]
  defstruct [:content, :member]
end

defmodule Combo.PubSub.RemoteSender do
  @moduledoc false
  @behaviour Combo.PubSub.Sender

  @impl true
  def send(pid, meta, message, state) do
    Kernel.send(pid, {:sent, node(), meta, message, state})
    state
  end
end

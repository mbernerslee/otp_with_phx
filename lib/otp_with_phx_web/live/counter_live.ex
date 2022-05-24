############# Start new addition ! #############
defmodule OtpWithPhxWeb.CounterLive do
  use OtpWithPhxWeb, :live_view

  alias OtpWithPhx.Counter
  alias Phoenix.PubSub

  def mount(_, _, socket) do
    if connected?(socket) do
      PubSub.subscribe(OtpWithPhx.PubSub, "count")
    end

    socket = assign(socket, :count, Counter.read())

    {:ok, socket}
  end

  def handle_event("increment", _, socket) do
    Counter.increment()
    {:noreply, socket}
  end

  def handle_info({:count, count}, socket) do
    {:noreply, assign(socket, :count, count)}
  end
end

############# End new addition !   #############

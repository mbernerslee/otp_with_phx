############# Start new addition ! #############
defmodule OtpWithPhx.Counter do
  use GenServer
  alias Phoenix.PubSub

  @name :counter
  @default_options [name: @name]
  @initial_count 0

  def child_spec do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [@default_options]}
    }
  end

  def process_name, do: @name

  def start_link(genserver_options \\ @default_options) do
    GenServer.start_link(__MODULE__, @initial_count, genserver_options)
  end

  def read(pid_or_name \\ @name) do
    GenServer.call(pid_or_name, :read)
  end

  def increment(pid_or_name \\ @name) do
    GenServer.call(pid_or_name, :increment)
  end

  @impl true
  def init(initial_count) do
    {:ok, initial_count}
  end

  @impl true
  def handle_call(:read, _from, count) do
    {:reply, count, count}
  end

  def handle_call(:increment, _from, count) do
    count = count + 1
    PubSub.broadcast!(OtpWithPhx.PubSub, "count", {:count, count})
    {:reply, count, count}
  end
end

############# End new addition !   #############

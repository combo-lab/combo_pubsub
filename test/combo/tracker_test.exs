defmodule Combo.TrackerTest do
  use ExUnit.Case, async: true

  defmodule MyTracker do
    use Combo.Tracker
    def init(state), do: {:ok, state}
    def handle_diff(_diff, state), do: {:ok, state}
  end

  test "generates child spec" do
    assert MyTracker.child_spec([]) == %{
             id: Combo.TrackerTest.MyTracker,
             start: {Combo.TrackerTest.MyTracker, :start_link, [[]]},
             type: :supervisor
           }
  end
end

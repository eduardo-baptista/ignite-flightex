defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @spec save(Booking.t()) :: {:ok, binary()}
  def save(%Booking{id: uuid} = booking) do
    Agent.update(__MODULE__, &update_booking_by_uuid(&1, booking))
    {:ok, uuid}
  end

  @spec get(binary()) :: {:ok, Booking.t()} | {:error, String.t()}
  def get(uuid) do
    Agent.get(__MODULE__, &get_booking_by_uuid(&1, uuid))
  end

  defp update_booking_by_uuid(state, %Booking{id: uuid} = booking) do
    Map.put(state, uuid, booking)
  end

  defp get_booking_by_uuid(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end
end

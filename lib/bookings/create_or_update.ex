defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def call(%{
        complete_date: complete_date,
        local_origin: local_origin,
        local_destination: local_destination,
        user_id: user_id
      }) do
    with {:ok, date} <- build_date_from_array(complete_date),
         {:ok, booking} <- Booking.build(date, local_origin, local_destination, user_id) do
      BookingAgent.save(booking)
    else
      error -> error
    end
  end

  defp build_date_from_array([year, month, day, hour, minute, second]) do
    NaiveDateTime.new(year, month, day, hour, minute, second)
  end

  defp build_date_from_array(_), do: {:error, "invalid date params"}
end

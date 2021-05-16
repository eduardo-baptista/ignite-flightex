defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(file_name \\ "report.csv") do
    content = build_bookings()

    File.write(file_name, content)
  end

  defp build_bookings do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.map(&format_booking_row/1)
  end

  defp format_booking_row(%Booking{
         user_id: user,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    "#{user},#{local_origin},#{local_destination},#{NaiveDateTime.to_iso8601(complete_date)}\n"
  end
end

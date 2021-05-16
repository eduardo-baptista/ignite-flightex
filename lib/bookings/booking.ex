defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  @type t :: %__MODULE__{
          complete_date: NaiveDateTime.t(),
          local_origin: String.t(),
          local_destination: String.t(),
          user_id: binary(),
          id: binary()
        }

  @spec build(NaiveDateTime.t(), String.t(), String.t(), binary()) :: {:ok, __MODULE__.t()}
  def build(complete_date, local_origin, local_destination, user_id) do
    {:ok,
     %__MODULE__{
       complete_date: complete_date,
       local_origin: local_origin,
       local_destination: local_destination,
       user_id: user_id,
       id: UUID.uuid4()
     }}
  end
end

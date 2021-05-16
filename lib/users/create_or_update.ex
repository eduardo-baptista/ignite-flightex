defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  @type user_params :: %{name: String.t(), email: String.t(), cpf: String.t()}

  @spec call(user_params()) :: {:error, String.t()} | {:ok, String.t()}
  def call(%{name: name, email: email, cpf: cpf}) do
    name
    |> User.build(email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)
    {:ok, "User create or update successfully"}
  end

  defp save_user({:error, _reason} = error), do: error
end

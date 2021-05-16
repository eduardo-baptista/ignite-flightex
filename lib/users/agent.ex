defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @spec save(User.t()) :: {:ok, User.t()}
  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_user_by_cpf(&1, user))
    {:ok, user}
  end

  @spec get(String.t()) :: {:ok, User.t()} | {:error, String.t()}
  def get(cpf) do
    Agent.get(__MODULE__, &get_user_by_cpf(&1, cpf))
  end

  defp update_user_by_cpf(state, %User{cpf: cpf} = user) do
    Map.put(state, cpf, user)
  end

  defp get_user_by_cpf(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end

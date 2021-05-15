defmodule Flightex.Users.User do
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  @type t :: %__MODULE__{name: String.t(), email: String.t(), cpf: String.t(), id: binary()}

  @spec build(String.t(), String.t(), String.t()) :: {:error, String.t()} | {:ok, __MODULE__.t()}
  def build(name, email, cpf) when is_binary(cpf) do
    {:ok,
     %__MODULE__{
       cpf: cpf,
       name: name,
       email: email,
       id: UUID.uuid4()
     }}
  end

  def build(_name, _email, _cpf), do: {:error, "Cpf must be a String"}
end

defmodule NationalVoterFile.Factories do
  @moduledoc false

  # with Ecto
  use ExMachina.Ecto, repo: NationalVoterFile.Repo

  @spec set_password(NationalVoterFile.User.t, String.t) :: NationalVoterFile.User.t
  def set_password(user, password) do
    hashed_password = Comeonin.Bcrypt.hashpwsalt(password)
    %{user | encrypted_password: hashed_password}
  end

  def user_factory do
    %NationalVoterFile.User{
      email: sequence(:email, &"email-#{&1}@example.com")
    }
  end
end

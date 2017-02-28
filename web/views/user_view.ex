defmodule NationalVoterFile.UserView do
  use NationalVoterFile.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :email, :inserted_at, :updated_at
  ]

  @doc """
  Returns the user email or an empty string, depending on the user
  being rendered is the authenticated user, or some other user.

  Users can only see their own emails. Everyone else's are private.
  """
  def email(user, %Plug.Conn{assigns: %{current_user: current_user}}) do
    if user.id == current_user.id, do: user.email, else: ""
  end
  def email(_user, _conn), do: ""
end

defmodule NationalVoterFile.Plug.SetSentryUserContext do
  def init(opts), do: opts

  def call(conn, _opts), do: conn |> set_context

  defp set_context(%{assigns: %{current_user: user}} = conn) do
    Sentry.Context.set_user_context(%{
      id: user.id,
      email: user.email
    })
    conn
  end

  defp set_context(conn), do: conn
end

defmodule NationalVoterFile.ViewCase do
  @moduledoc """
  This module defines the test case to be used by
  tests for views defined in the application.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import NationalVoterFile.Factories
      import Phoenix.View, only: [render: 3]
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(NationalVoterFile.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(NationalVoterFile.Repo, {:shared, self()})
    end

    :ok
  end
end

defmodule NationalVoterFile.Helpers.Query do
  import NationalVoterFile.Helpers.String, only: [coalesce_id_string: 1]
  import Ecto.Query, only: [where: 3, limit: 2, order_by: 2]

  def id_filter(query, id_list) do
    ids = id_list |> coalesce_id_string
    query |> where([object], object.id in ^ids)
  end

  def limit_filter(query, %{"limit" => count}) do
    query |> limit(^count)
  end
  def limit_filter(query, _), do: query

  # sorting

  def sort_by_newest_first(query), do: query |> order_by([desc: :inserted_at])

  # end sorting
end

defmodule GenReport.Utils do
  def map_deep_merge(map1, map2) do
    Map.merge(map1, map2, &resolve_conflict/3)
  end

  defp resolve_conflict(_key, map1, map2) when is_map(map1) and is_map(map2) do
    map_deep_merge(map1, map2)
  end

  defp resolve_conflict(_key, value1, value2) do
    value1 + value2
  end
end

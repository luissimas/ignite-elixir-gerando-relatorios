defmodule GenReport do
  alias GenReport.Parser

  def build(), do: {:error, "Insira o nome de um arquivo"}

  @report_structure %{"all_hours" => %{}, "hours_per_month" => %{}, "hours_per_year" => %{}}

  def build(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(%{}, &group_by_user/2)
    |> Enum.reduce(@report_structure, &build_report/2)
  end

  defp build_report({user, data}, report) do
    %{
      report
      | "all_hours" => Map.put(report["all_hours"], user, get_all_hours(data)),
        "hours_per_month" => Map.put(report["hours_per_month"], user, get_hours_by_month(data)),
        "hours_per_year" => Map.put(report["hours_per_year"], user, get_hours_by_year(data))
    }
  end

  defp group_by_user([name, hours, day, month, year], report) do
    data = %{hours: hours, day: day, month: month, year: year}

    Map.update(report, name, [data], fn existing -> existing ++ [data] end)
  end

  defp get_hours_by_year(data) do
    Enum.reduce(data, %{}, fn %{year: year, hours: hours}, acc ->
      Map.update(acc, year, hours, fn existing -> existing + hours end)
    end)
  end

  defp get_hours_by_month(data) do
    Enum.reduce(data, %{}, fn %{month: month, hours: hours}, acc ->
      Map.update(acc, month, hours, fn existing -> existing + hours end)
    end)
  end

  defp get_all_hours(data) do
    Enum.reduce(data, 0, fn %{hours: hours}, acc -> acc + hours end)
  end
end

GenReport.build("gen_report.csv")

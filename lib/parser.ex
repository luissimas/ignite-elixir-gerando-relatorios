defmodule GenReport.Parser do
  @months {
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  }

  def parse_file(file_name) do
    "reports/#{file_name}"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> parse_values()
  end

  defp parse_values([name, hours, day, month, year]) do
    [
      String.downcase(name),
      String.to_integer(hours),
      String.to_integer(day),
      elem(@months, String.to_integer(month) - 1),
      String.to_integer(year)
    ]
  end
end

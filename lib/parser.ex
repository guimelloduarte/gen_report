defmodule GenReport.Parser do
  def parse_file(file_name) do
    "reports/#{file_name}"
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)

    # |> Enum.each(fn x -> IO.inspect(x) end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(0, &String.to_atom/1)
    |> List.update_at(1, &String.to_integer/1)
    |> List.update_at(2, &String.to_atom/1)
    |> List.update_at(3, &adjust_month/1)
    |> List.update_at(3, &String.to_atom/1)
    |> List.update_at(4, &String.to_atom/1)
  end

  defp adjust_month(_number = "1"), do: "janeiro"
  defp adjust_month(_number = "2"), do: "fevereiro"
  defp adjust_month(_number = "3"), do: "março"
  defp adjust_month(_number = "4"), do: "abril"
  defp adjust_month(_number = "5"), do: "maio"
  defp adjust_month(_number = "6"), do: "junho"
  defp adjust_month(_number = "7"), do: "julho"
  defp adjust_month(_number = "8"), do: "agosto"
  defp adjust_month(_number = "9"), do: "setembro"
  defp adjust_month(_number = "10"), do: "outubro"
  defp adjust_month(_number = "11"), do: "novembro"
  defp adjust_month(_number = "12"), do: "dezembro"

end

defmodule GenReport do
  alias GenReport.Parser

  @avaliable_names [
    :Daniele,
    :Mayk,
    :Giuliano,
    :Cleiton,
    :Jakeliny,
    :Joseph,
    :Diego,
    :Danilo,
    :Rafael,
    :Vinicius
  ]

  @months [
    :janeiro,
    :fevereiro,
    :março,
    :abril,
    :maio,
    :junho,
    :julho,
    :agosto,
    :setembro,
    :outubro,
    :novembro,
    :dezembro
  ]

  @years [
    :"2016",
    :"2017",
    :"2018",
    :"2019",
    :"2020"
  ]

  def build(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_all_hours(line, report) end)
  end

  defp sum_all_hours([name, work_hours, _day, month, year], %{all_hours: all_hours, hours_per_month: hours_per_month, hours_per_year: hours_per_year} = report) do
    all_hours = Map.put(all_hours, name, all_hours[name] + work_hours)
    hours_per_month = put_in(hours_per_month, [name, month], hours_per_month[name][month] + work_hours)
    hours_per_year = put_in(hours_per_year, [name, year], hours_per_year[name][year] + work_hours)

    %{report | all_hours: all_hours, hours_per_month: hours_per_month, hours_per_year: hours_per_year}
  end

  defp build_map(value, key) do
    Enum.into(key, %{}, &{&1, value})
  end

  defp report_acc do
    all_hours =
        build_map(0, @avaliable_names)

    hours_per_month =
      build_map(0, @months)
      |> build_map(@avaliable_names)

    hours_per_year =
      build_map(0, @years)
      |> build_map(@avaliable_names)

    %{all_hours: all_hours, hours_per_month: hours_per_month, hours_per_year: hours_per_year} #criar os mapas aqui
  end


end

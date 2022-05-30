defmodule GenReportTest do
  use ExUnit.Case

  alias GenReport
  alias GenReport.Support.ReportFixture

  @file_name "gen_report.csv"
  @file_names ["part_1.csv", "part_2.csv", "part_3.csv"]

  describe "build/1" do
    test "When passing file name return a report" do
      response = GenReport.build(@file_name)

      assert response == ReportFixture.build()
    end

    test "When no filename was given, returns an error" do
      response = GenReport.build()

      assert response == {:error, "Insira o nome de um arquivo"}
    end
  end

  describe "build_from_many/1" do
    test "When passing file name return a report" do
      response = GenReport.build_from_many(@file_names)

      assert response == ReportFixture.build()
    end

    test "When no filename list was given, returns an error" do
      response = GenReport.build_from_many("any-argument")

      assert response == {:error, "Invalid argument, filenames must be a list of strings"}
    end
  end
end

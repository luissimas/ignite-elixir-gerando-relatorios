defmodule GenReport.UtilsTest do
  use ExUnit.Case

  alias GenReport.Utils

  describe "map_deep_merge/2" do
    test "merges flat maps" do
      map1 = %{
        key1: 5,
        key2: 3,
        key3: 8,
        key4: 2,
        key5: 3
      }

      map2 = %{
        key1: 13,
        key2: 0,
        key3: 3,
        key4: 8,
        key5: 7
      }

      expected = %{
        key1: 18,
        key2: 3,
        key3: 11,
        key4: 10,
        key5: 10
      }

      result = Utils.map_deep_merge(map1, map2)

      assert result == expected
    end

    test "merges nested maps" do
      map1 = %{
        key1: %{
          key2: 3,
          key3: 8,
          key4: 2,
          key5: 3
        },
        key2: 3,
        key3: 8,
        key4: %{
          key2: %{
            key3: 8,
            key4: 2,
            key5: 3
          },
          key3: 8
        },
        key5: 3
      }

      map2 = %{
        key1: %{
          key2: 8,
          key3: 2,
          key4: 3,
          key5: 0
        },
        key2: 0,
        key3: 3,
        key4: %{
          key2: %{
            key3: 82,
            key4: 38,
            key5: 7
          },
          key3: 9
        },
        key5: 1
      }

      expected = %{
        key1: %{
          key2: 11,
          key3: 10,
          key4: 5,
          key5: 3
        },
        key2: 3,
        key3: 11,
        key4: %{
          key2: %{
            key3: 90,
            key4: 40,
            key5: 10
          },
          key3: 17
        },
        key5: 4
      }

      result = Utils.map_deep_merge(map1, map2)

      assert result == expected
    end
  end
end

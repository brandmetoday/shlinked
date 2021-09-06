defmodule Shlinkedin.NewsTest do
  use Shlinkedin.DataCase

  alias Shlinkedin.News

  describe "headline ordering" do
    @criteria [paginate: %{page: 1, per_page: 5}]

    setup do
      profile = Shlinkedin.ProfilesFixtures.profile_fixture()
      create_headlines(10, profile)
      %{profile: profile}
    end

    defp create_headlines(num, profile) do
      Enum.each(
        1..num,
        fn num ->
          {:ok, _article} =
            News.create_article(profile, %News.Article{}, %{headline: Integer.to_string(num)})
        end
      )
    end

    test "check headline ordering first page" do
      headlines =
        News.list_articles(@criteria) |> Enum.map(fn a -> String.to_integer(a.headline) end)

      assert headlines == [1, 2, 3, 4, 5]
    end

    test "check headline ordering second page" do
      headlines =
        News.list_articles(paginate: %{page: 2, per_page: 5})
        |> Enum.map(fn a -> String.to_integer(a.headline) end)

      assert headlines == [6, 7, 8, 9, 10]
    end
  end
end

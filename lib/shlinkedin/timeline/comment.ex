defmodule Shlinkedin.Timeline.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    has_many(:likes, Shlinkedin.Timeline.CommentLike, on_delete: :nilify_all)
    belongs_to :post, Shlinkedin.Timeline.Post
    belongs_to :profile, Shlinkedin.Profiles.Profile
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
    |> validate_length(:body, max: 240)
  end
end

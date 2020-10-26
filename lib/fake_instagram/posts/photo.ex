defmodule FakeInstagram.Posts.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :caption, :string
    field :image_url, :string

    belongs_to :user, FakeInstagram.Accounts.User

    has_many :like_photos, FakeInstagram.Reaction.LikePhoto
    has_many :comments, FakeInstagram.Posts.Comment

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:image_url, :caption, :user_id])
    |> validate_required([:image_url, :user_id])
  end
end

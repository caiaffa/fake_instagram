defmodule FakeInstagram.Posts.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photo_comments" do
    field :text, :string

    belongs_to :user, FakeInstagram.Accounts.User
    belongs_to :photo, FakeInstagram.Posts.Photo

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:text, :user_id, :photo_id])
    |> validate_required([:text, :user_id, :photo_id])
  end
end

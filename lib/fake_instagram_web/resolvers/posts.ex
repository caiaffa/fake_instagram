defmodule FakeInstagramWeb.Resolvers.Posts do
  alias FakeInstagram.Posts

  def photos(_, _, _) do
    {:ok, Posts.list_photos()}
  end

  def photo(_, %{id: id}, _) do
    {:ok, Posts.get_photo!(id)}
  end

  def presign_url(_, _, _) do
    {:ok, FakeInstagram.Posts.get_presign_url()}
  end
end

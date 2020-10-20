defmodule FakeInstagramWeb.Resolvers.Posts do
  alias FakeInstagram.Posts

  def photos(_, _, _) do
    {:ok, Posts.list_photos()}
  end
end

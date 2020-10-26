defmodule FakeInstagramWeb.Resolvers.Reactions do
  alias FakeInstagram.Reaction

  def like_photo(_, %{photo_id: photo_id}, %{context: %{current_user: current_user}}) do
    with {:ok, message} <- Reaction.like_photo(photo_id, current_user.id) do
      {:ok, message}
    end
  end

  def viewer_like_photo(%{id: id}, _, %{context: %{current_user: current_user}}) do
    with {:ok, message} <- Reaction.viewer_like_photo(id, current_user.id) do
      {:ok, message}
    end
  end
end

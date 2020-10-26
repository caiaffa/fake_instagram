defmodule FakeInstagram.Reaction do
  @moduledoc """
  The Reaction context.
  """

  import Ecto.Query, warn: false
  alias FakeInstagram.Repo

  alias FakeInstagram.Reaction.LikePhoto

  def like_photo(photo_id, user_id) do
    case like_photo_exists(photo_id, user_id) do
      nil ->
        create_like_photo(%{photo_id: photo_id, user_id: user_id})
        {:ok, true}

      result ->
        delete_like_photo(result)
        {:ok, false}
    end
  end

  def viewer_like_photo(photo_id, user_id) do
    case like_photo_exists(photo_id, user_id) do
      nil ->
        {:ok, false}

      _ ->
        {:ok, true}
    end
  end

  defp like_photo_exists(photo_id, user_id) do
    query =
      from p in LikePhoto,
        where: p.photo_id == ^photo_id and p.user_id == ^user_id

    query
    |> Repo.one()
  end

  @doc """
  Returns the list of like_photos.

  ## Examples

      iex> list_like_photos()
      [%LikePhoto{}, ...]

  """
  def list_like_photos do
    Repo.all(LikePhoto)
  end

  @doc """
  Gets a single like_photo.

  Raises `Ecto.NoResultsError` if the Like photo does not exist.

  ## Examples

      iex> get_like_photo!(123)
      %LikePhoto{}

      iex> get_like_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_like_photo!(id), do: Repo.get!(LikePhoto, id)

  @doc """
  Creates a like_photo.

  ## Examples

      iex> create_like_photo(%{field: value})
      {:ok, %LikePhoto{}}

      iex> create_like_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_like_photo(attrs \\ %{}) do
    %LikePhoto{}
    |> LikePhoto.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a like_photo.

  ## Examples

      iex> update_like_photo(like_photo, %{field: new_value})
      {:ok, %LikePhoto{}}

      iex> update_like_photo(like_photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_like_photo(%LikePhoto{} = like_photo, attrs) do
    like_photo
    |> LikePhoto.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a like_photo.

  ## Examples

      iex> delete_like_photo(like_photo)
      {:ok, %LikePhoto{}}

      iex> delete_like_photo(like_photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_like_photo(%LikePhoto{} = like_photo) do
    Repo.delete(like_photo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking like_photo changes.

  ## Examples

      iex> change_like_photo(like_photo)
      %Ecto.Changeset{data: %LikePhoto{}}

  """
  def change_like_photo(%LikePhoto{} = like_photo, attrs \\ %{}) do
    LikePhoto.changeset(like_photo, attrs)
  end
end

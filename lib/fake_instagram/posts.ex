defmodule FakeInstagram.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias FakeInstagram.Repo

  alias FakeInstagram.Posts.{Photo, Comment}

  @doc """
  Returns the list of photos.

  ## Examples

      iex> list_photos()
      [%Photo{}, ...]

  """
  def list_photos do
    query = from p in Photo, order_by: [desc: :inserted_at]
    Repo.all(query)
  end

  @doc """
  Gets a single photo.

  Raises `Ecto.NoResultsError` if the Photo does not exist.

  ## Examples

      iex> get_photo!(123)
      %Photo{}

      iex> get_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_photo!(id), do: Repo.get!(Photo, id)

  @doc """
  Creates a photo.

  ## Examples

      iex> create_photo(%{field: value})
      {:ok, %Photo{}}

      iex> create_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_photo(attrs \\ %{}) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a photo.

  ## Examples

      iex> update_photo(photo, %{field: new_value})
      {:ok, %Photo{}}

      iex> update_photo(photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_photo(%Photo{} = photo, attrs) do
    photo
    |> Photo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a photo.

  ## Examples

      iex> delete_photo(photo)
      {:ok, %Photo{}}

      iex> delete_photo(photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_photo(%Photo{} = photo) do
    Repo.delete(photo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking photo changes.

  ## Examples

      iex> change_photo(photo)
      %Ecto.Changeset{data: %Photo{}}

  """
  def change_photo(%Photo{} = photo, attrs \\ %{}) do
    Photo.changeset(photo, attrs)
  end

  def get_presign_url do
    uuid = UUID.uuid4()
    bucket = "photos"
    config = %{region: "us-east-1"}
    query_params = [{"ContentType", "image/jpeg"}, {"ACL", "public-read"}]
    presign_options = [virtual_host: false, query_params: query_params]

    {:ok, url} =
      ExAws.Config.new(:s3, config)
      |> ExAws.S3.presigned_url(:put, bucket, "#{uuid}.jpg", presign_options)

    %{upload_url: url, url: get_image_url(bucket, uuid)}
  end

  def get_image_url(bucket, uuid) do
    "https://s3.amazonaws.com/fakeinstagram-beta/#{bucket}/#{uuid}.jpg"
  end

  @doc """
  Returns the list of photo_comments.

  ## Examples

      iex> list_photo_comments()
      [%Comment{}, ...]

  """
  def list_photo_comments do
    Repo.all(Comment)
  end

  @doc """
  Gets a single comment.

  Raises `Ecto.NoResultsError` if the Comment does not exist.

  ## Examples

      iex> get_comment!(123)
      %Comment{}

      iex> get_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comment!(id), do: Repo.get!(Comment, id)

  @doc """
  Creates a comment.

  ## Examples

      iex> create_comment(%{field: value})
      {:ok, %Comment{}}

      iex> create_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comment.

  ## Examples

      iex> update_comment(comment, %{field: new_value})
      {:ok, %Comment{}}

      iex> update_comment(comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comment.

  ## Examples

      iex> delete_comment(comment)
      {:ok, %Comment{}}

      iex> delete_comment(comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comment changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end

  def get_comments_for_photo(photo_id) do
    query = from c in Comment, where: c.photo_id == ^photo_id, order_by: [desc: :inserted_at]

    query
    |> Repo.all()
  end
end

defmodule FakeInstagramWeb.Schema do
  use Absinthe.Schema

  alias FakeInstagramWeb.Resolvers
  alias FakeInstagramWeb.Schema.Middleware

  import_types(__MODULE__.PostsTypes)
  import_types(__MODULE__.AccountsTypes)

  alias FakeInstagram.Accounts

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "Get list of photo"
    field :photos, list_of(:photo) do
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Posts.photos/3)
    end

    @desc "Get a single photo from his id"
    field :photo, :photo do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Posts.photo/3)
    end

    @desc "Get a presign url for upload an photo"
    field :presign_url, :presign_url do
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Posts.presign_url/3)
    end

    @desc "Get all commments for a photo"
    field :comments, non_null(list_of(:comment)) do
      arg(:photo_id, non_null(:id))
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Posts.get_comments/3)
    end
  end

  mutation do
    @desc "Login as a user"
    field :login, :user_session do
      arg(:token, :string)
      arg(:provider, type: :provider)
      resolve(&Resolvers.Accounts.login/3)
    end

    @desc "Create a photo"
    field :create_photo, :photo do
      arg(:image_url, :string)
      arg(:caption, :string)
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Posts.create_photo/3)
    end

    @desc "Like or Unlike a photo"
    field :like_photo, :boolean do
      arg(:photo_id, non_null(:id))
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Reactions.like_photo/3)
    end

    @desc "Create a comment for a photo"
    field :creat_comment, :comment do
      arg(:photo_id, non_null(:id))
      arg(:text, non_null(:string))
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Posts.create_comment/3)
    end
  end
end

defmodule FakeInstagramWeb.Schema do
  use Absinthe.Schema

  import_types(__MODULE__.PostsTypes)

  alias FakeInstagramWeb.Resolvers

  query do
    @desc "Get list of photo"
    field :photos, list_of(:photo) do
      resolve(&Resolvers.Posts.photos/3)
    end
  end
end

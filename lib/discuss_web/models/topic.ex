defmodule Discuss.Topic do
  use DiscussWeb, :model

  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_require([:title])
  end
end

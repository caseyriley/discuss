defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Topic

  def index(conn, _params) do
    topics = Discuss.Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    # struct = %Discuss.Topic{}
    # params = %{}
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", changeset: changeset
  end

  #topic is destructured from params via a unique syntax:
  ##params = %{"topic" => "asdf"}
  ##%{"topic" => string} = params
  ##string #"asdf"
  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Discuss.Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end

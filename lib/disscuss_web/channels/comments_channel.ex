defmodule DisscussWeb.CommentsChannel do
  use DisscussWeb, :channel
  alias Disscuss.{Topic, Repo, Comment}

  def join("comments:" <> topic_id, _param, socket) do
    # IO.puts(name) "comments:6"
    topic_id = String.to_integer(topic_id)
    topic = Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])
    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => content} = _message, %Phoenix.Socket{assigns: %{topic: topic, user_id: user_id}} = socket) do
    # IO.puts(name) #"comment:add"

    changeset = topic
    |> Ecto.build_assoc(:comments, user_id: user_id)
    |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        comment = Repo.preload(comment, :user)
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
  def handle_in(_name, %{"content" => content} = _message, %Phoenix.Socket{assigns: %{topic: topic}} = socket) do
    changeset = topic
    |> Ecto.build_assoc(:comments)
    |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        comment = Repo.preload(comment, :user)
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end

Logger.configure(level: :info)
Application.put_env(:combo_pubsub, :test_adapter, {Combo.PubSub.PG, []})
exclude = Keyword.get(ExUnit.configuration(), :exclude, [])

Supervisor.start_link(
  [{Combo.PubSub, name: Combo.PubSubTest, pool_size: 4}],
  strategy: :one_for_one
)

unless :clustered in exclude do
  Combo.PubSub.Cluster.spawn([
    :"node1@127.0.0.1",
    :"node2@127.0.0.1",
    {:"node3@127.0.0.1", pool_size: 4, broadcast_pool_size: 1},
    {:"node4@127.0.0.1", pool_size: 1}
  ])
end

ExUnit.start()

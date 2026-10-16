Merge following docs:

## Migrating custom dispatchers

Custom dispatchers and the `:metadata` subscription option are deprecated in favor of
per-subscription senders. Existing dispatchers continue to work, except that subscribing
with `:metadata` in the shape of `[atom | term]` now raises. That shape is reserved
for senders.

To migrate:

1. Implement the `Phoenix.PubSub.Sender` behaviour in your delivery module. Its
   `send/4` callback receives one subscriber pid, its metadata, the message, and an
   accumulator. Move the delivery logic from `dispatch/3` into this callback. PubSub
   handles iterating over subscribers and excluding the originating pid for
   `broadcast_from` calls.
2. Replace `metadata: metadata` in subscriptions with `sender: {MySender, metadata}`:

   ```elixir
   Phoenix.PubSub.subscribe(MyApp.PubSub, "topic", sender: {MySender, metadata})
   ```

3. Remove custom dispatcher arguments from broadcast calls and remove the `:dispatcher`
   option from your PubSub child specification to use the default `Phoenix.PubSub`
   dispatcher. Custom dispatchers control delivery themselves and do not automatically
   invoke senders, so changing subscriptions alone is not sufficient.
4. Replace `unsubscribe_match/3` calls for migrated subscriptions with
   `unsubscribe_sender/3`, passing the same sender tuple:

   ```elixir
   Phoenix.PubSub.unsubscribe_sender(MyApp.PubSub, "topic", {MySender, metadata})
   ```

Pick the useful information from following content, and merge it into docs:

## Custom dispatching

Phoenix.PubSub allows developers to perform custom dispatching
by passing a `dispatcher` module which is responsible for local
message deliveries.

The dispatcher must be available on all nodes running the PubSub
system. The `dispatch/3` function of the given module will be
invoked with the subscriptions entries, the broadcaster identifier
(either a pid or `:none`), and the message to broadcast.

You may want to use the dispatcher to perform special delivery for
certain subscriptions. This can be done by passing the :metadata
option during subscriptions. For instance, Phoenix Channels use a
custom `value` to cache encoded messages, allowing messages broadcast
to thousands or even millions of users to be encoded once and written
directly to sockets instead of being encoded per channel.

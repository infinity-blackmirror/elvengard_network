defmodule LoginServer do
  @moduledoc """
  Documentation for LoginServer.
  """

  use HeavensStrike.Game.LoginServer,
    packet_resolver: LoginServer.PacketResolver,
    port: 4002

  require Logger
  alias HeavensStrike.Game.Client

  def handle_init(args) do
    port = get_in(args, [:port])
    Logger.info("Login server started on port #{port}")
  end

  def handle_connection(%Client{id: id} = _client) do
    Logger.info("New connection: #{id}")
  end

  def handle_disconnection(%Client{id: id} = _client, reason) do
    Logger.info("#{id} is now disconnected (reason: #{inspect(reason)})")
  end

  def handle_message(%Client{id: id} = _client, message) do
    Logger.info("New message from #{id} (len: #{byte_size(message)})")
  end

  # TODO: Change this function and remove `LoginServer.Crypto.encrypt` call.
  # Use the resolver instead
  def handle_client_accepted(%Client{id: id} = client, args) do
    e_packet = LoginServer.Crypto.encrypt(args)
    Logger.info("Client accepted: #{id}")
    Client.send(client, e_packet)
  end

  # TODO: Change this function and remove `LoginServer.Crypto.encrypt` call.
  # Use the resolver instead
  def handle_client_refused(%Client{id: id} = client, reason) do
    e_reason = LoginServer.Crypto.encrypt("fail #{reason}")
    Logger.info("Client refused: #{id} - #{reason}")
    Client.send(client, e_reason)
  end
end

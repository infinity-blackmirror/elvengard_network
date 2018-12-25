defmodule LoginServer.PacketHandler do
  @moduledoc """
  Reveived packet handler.
  """

  use HeavensStrike.General.Packet

  packet "NoS0575" do
    field :session, :integer
    field :username, :string
    field :password, :string
    field :unknown, :string
    field :version, :string
    resolve &LoginServer.Player.player_connect/2
  end
end

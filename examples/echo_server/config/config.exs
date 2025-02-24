import Config

config :logger, :console,
  level: :debug,
  format: "$time $metadata[$level] $message\n",
  metadata: [:application],
  colors: [info: :green]

config :echo_server, EchoServer.Endpoint,
  listener_name: :echo_server,
  transport: :ranch_tcp,
  transport_opts: [ip: "127.0.0.1", port: 3333],
  protocol: EchoServer.Endpoint.Protocol

config :echo_server, EchoServer.Endpoint.Protocol,
  # Here, the packet handler is not needed because we bypass the packet
  # handling by returning `ignore` in `handle_message/2`
  packet_handler: :unset,
  # Here we are not using packet coder/decoder.
  # We send raw packets
  packet_codec: :unset

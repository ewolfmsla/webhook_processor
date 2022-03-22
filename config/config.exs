import Config

config :webhook_processor, def_reply: "pong!"

import_config "#{config_env()}.exs"

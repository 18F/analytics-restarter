require "./lib/app"

Rack::Handler.default.run Application.new, Port: ENV["PORT"]

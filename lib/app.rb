require "sinatra"

# An app to render a 200 for New Relic monitoring
class Application < Sinatra::Base
  get "/" do
    Time.now.to_s
  end
end

require_relative "./application"
require_relative "./test_application"

app = Rack::Builder.app do
  map "/test" do
    run Heartbeat::Application
  end

  map "/" do
    run Heartbeat::TestApplication
  end
end

run app

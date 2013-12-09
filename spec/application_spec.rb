require "spec_helper"

describe "application" do
  def app
    Sinatra::Application
  end

  def response
    last_response
  end

  def json
    @json ||= JSON.parse(last_response.body)
  end

  describe "/" do
    it "renders the index page" do
      get "/"
      response.should be_ok
    end
  end

  describe "/today.json" do
    pending
  end
end

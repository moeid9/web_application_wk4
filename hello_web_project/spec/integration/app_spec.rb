# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /names" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/names?names=Julia, Mary, Karim")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq('Julia, Mary, Karim')
    end
  end

  context "GET /hello" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/hello")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Hello<h1>')
    end
  end

  context "POST/" do
    it 'returns 200 OK with right content' do
        response = post("/sort-names?names= Joe, Alice, Zoe, Julia, Kieran")

        expect(response.status).to eq(200)
        expect(response.body).to eq(' Alice, Joe, Julia, Kieran, Zoe')
    end
  end

  context "GET to /" do
    it 'contains a h1 title' do
      response = get('/')
  
      expect(response.body).to include('<h1>Hello<h1>')
    end
    it 'contains a div' do
      response = get('/')
  
      expect(response.body).to include('<div>')
    end
  end
end



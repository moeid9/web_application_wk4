require "spec_helper"
require_relative '../../app.rb'
require 'rack/test'
describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /albums" do
    it 'returns a list of albums' do
      # Assuming the post with id 1 exists.
      response = get('/albums')
      expected_response = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end

  context "GET /artists" do
    it 'returns a list of artists' do
      # Assuming the post with id 1 exists.
      response = get('/artists')
      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end

  context "POST /albums" do
    it 'should create a new album' do
      response = post(
        '/albums',
        title: 'OK Computer',
        release_year: '1997',
        artist_id: '1'
      )

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')

      expect(response.body).to include('OK Computer')
    end
  end

  context "POST /artists" do
    it 'should create a new artist' do
      response = post(
        '/artists',
        name: 'NewJeans',
        genre: 'KPop'
      )

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/artists')

      expect(response.body).to include('NewJeans')
    end
  end
end
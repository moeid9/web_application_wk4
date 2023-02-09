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
      

      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Albums</h1>')
      expect(response.body).to include ('<div>')
      expect(response.body).to include ('Surfer Rosa')
      expect(response.body).to include ('Waterloo')
      expect(response.body).to include ('Super Trouper')
    end

    it 'returns a list of albums with hypertext' do
      # Assuming the post with id 1 exists.
      response = get('/albums')
      

      expect(response.body).to include ('<a href="/albums/2"> Surfer Rosa </a>')
      expect(response.body).to include ('<a href="/albums/3"> Waterloo </a>')
      expect(response.body).to include ('<a href="/albums/4"> Super Trouper </a>')
      expect(response.body).to include ('<a href="/albums/5"> Bossanova </a>')
      expect(response.body).to include ('<a href="/albums/6"> Lover </a>')
    end
    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end

  context "GET /albums/:id" do
    it 'returns a list of a single album' do
      # Assuming the post with id 1 exists.
      response = get('/albums/2')
      

      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Surfer Rosa</h1>')
      expect(response.body).to include ('Release year: 1988')
      expect(response.body).to include ('Artist: Pixies')
    end
  end

  context "GET /artists" do
    it 'returns a list of artists' do
      # Assuming the post with id 1 exists.
      response = get('/artists')
      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

      expect(response.status).to eq(200)
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Artists</h1>')
      expect(response.body).to include ('<div>')
      expect(response.body).to include ('Pixies')

    end

    it 'returns a list of artists with hypertext' do
      # Assuming the post with id 1 exists.
      response = get('/artists')

      expect(response.body).to include ('<a href="/artists/2"> ABBA </a>')
      expect(response.body).to include ('<a href="/artists/3"> Taylor Swift </a>')
      expect(response.body).to include ('<a href="/artists/4"> Nina Simone </a>')
      
    end
  end

  context "GET /artists/:id" do
    it 'returns a list of a single album' do
      # Assuming the post with id 1 exists.
      response = get('/artists/1')
      

      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Pixies</h1>')
      expect(response.body).to include ('Genre: Rock')
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

  context "GET /albums/new" do
    it 'returns the form page' do
      response = get('/albums/new')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add an album</h1>')
  
      # Assert we have the correct form tag with the action and method.
      expect(response.body).to include('<form action="/albums" method="POST">')
      expect(response.body).to include('<input type = "text" name = "album_title" />')
      expect(response.body).to include('<input type = "text" name = "album_release_year" />')
      expect(response.body).to include('<input type = "text" name = "album_artist_id" />')
      # We can assert more things, like having
      # the right HTML form inputs, etc.
    end
  end
  
end
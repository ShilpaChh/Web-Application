require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums' do
    it 'should return the list of albums' do
      response = get('/albums')

      expected_response = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
      # via multiple cursor delete the white spaces and have , instead. We'll have comma separated list of the albums

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)

      # now implement this in sinatra app.rb
    end
  end

  context 'POST /albums' do
    it 'should create a new album' do
      response = post('/albums', 
        title: 'OK Computer', 
        release_year: '1997', 
        artist_id: '1'
        )

      expect(response.status).to eq(200)
      expect(response.body).to eq('')
          # rspec => 
          # expected: 200
          # got: 404
          # now implement this in sinatra app.rb

          response = get('/albums')
          expect(response.body).to include('OK Computer')
    end
          # rspec
  end

  # CH5 - Test-driving CRUD routes - Challenge - 1. Test-drive a route GET /artists, which returns the list of artists:
  context 'GET /artists' do
    it 'should return the list of artists' do
      response = get('/artists')

      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
      # now implement this in sinatra => app.rb
    end
  end

    # CH5 - Test-driving CRUD routes - Challenge - 2. Test-drive a route POST /artists, which creates a new artist in the database. Your test should verify the new artist is returned in the response of GET /artists.
    context 'POST /artists' do
      it 'should create a new artist' do
        response = post('/artists', 
          name: 'Wild nothing', 
          genre: 'Indie'
          )
  
        expect(response.status).to eq(200)
        expect(response.body).to eq('')
  
            response = get('/artists')
            expect(response.body).to include('Wild nothing')
      end
    end



end


# ➜  music_library_database_app git:(main) ✗ rspec

# AlbumRepository
#   finds all albums
#   finds one album
#   creates an album
#   deletes an album

# ArtistRepository
#   finds all artists
#   finds one artist
#   creates an album

# Application
#   GET /albums
#     should return the list of albums
#   POST /albums
#     should create a new album

# Finished in 0.11209 seconds (files took 0.23792 seconds to load)
# 9 examples, 0 failures
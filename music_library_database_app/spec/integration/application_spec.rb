require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # PHASE 3 - Ch1 - USING HTML TO CREATE WEBPAGES:
  #  context 'GET /' do
  #   it 'returns the html index' do
  #     response = get('/')

  #     expect(response.body).to include('<h1> Hello!</h1>')

  #     expect(response.body).to include('<img src="hello.jpg />')
  #   end
  # end

      # to make it dynamic:
      context 'GET /' do
        it 'returns the html hello message with the given name' do
          response = get('/', name: 'Shilpa')

          expect(response.body).to include('<h1> Hello Shilpa!</h1>')
        end

      # another variation:
        it 'returns the html hello message with a different name' do
          response = get('/', name: 'Meghna')

          expect(response.body).to include('<h1> Hello Meghna!</h1>')
        end

              # making Arrays as dynamic:
              it 'returns an html list of names' do
                response = get('/')
      
                expect(response.body).to include('<p>Harshita</p>')
                expect(response.body).to include('<p>Meghna</p>')
                expect(response.body).to include('<p>Rahul</p>')
                expect(response.body).to include('<p>Shilpa</p>')
              end

              # Dealing with conditions like having a password:
              it 'returns a hello page if the password is correct' do
                response = get('/', password: 'abcd')
      
                expect(response.body).to include('Hello!')
              end

              # or what happens when the password is incorrect:
              it 'returns a forbidden page if the password is incorrect' do
                response = get('/', password: 'junkpwd')
      
                expect(response.body).to include('Access forbidden!')
              end

    end


      # WEB APPS - Phase 3 - CH2 - Exercise: Test-drive and implement a GET /albums/:id route so it returns the HTML content for a single album:

      context "GET /albums/:id" do
        it 'should return info about album 1' do
          response = get('albums/2')

          expect(response.status).to eq(200)
          expect(response.body).to include('<h1>Surfer Rosa</h1>')
          expect(response.body).to include('Release year: 1988')
          expect(response.body).to include('Artist: Pixies')

          # <h1>Doolittle</h1>
          # <p>
          #   Release year: 1989
          #   Artist: Pixies
          # </p>

        end

      end
    

  context 'GET /albums' do
    xit 'should return the list of albums' do # skipping this as the following test has the ask for albums to be in HTML format.. 
      response = get('/albums')

      expected_response = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
      # via multiple cursor delete the white spaces and have , instead. We'll have comma separated list of the albums

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)

      # now implement this in sinatra app.rb
    end

    # Web Apps Phase 3 - Ch 2 - Challenge
    it 'returns the list of albums as an HTML page' do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Albums</h1>')
      expect(response.body).to include('Title: Surfer Rosa')
      expect(response.body).to include('Released: 1988')
      expect(response.body).to include('Title: Waterloo')
      expect(response.body).to include('Released: 1974')
  end

  end

  context "POST /albums" do
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
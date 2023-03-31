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
        xit 'returns the html hello message with the given name' do
          response = get('/', name: 'Shilpa')

          expect(response.body).to include('<h1> Hello Shilpa!</h1>')
        end

      # another variation:
        xit 'returns the html hello message with a different name' do
          response = get('/', name: 'Meghna')

          expect(response.body).to include('<h1> Hello Meghna!</h1>')
        end

              # making Arrays as dynamic:
              xit 'returns an html list of names' do
                response = get('/')
      
                expect(response.body).to include('<p>Harshita</p>')
                expect(response.body).to include('<p>Meghna</p>')
                expect(response.body).to include('<p>Rahul</p>')
                expect(response.body).to include('<p>Shilpa</p>')
              end

              # Dealing with conditions like having a password:
              xit 'returns a hello page if the password is correct' do
                response = get('/', password: 'abcd')
      
                expect(response.body).to include('Hello!')
              end

              # or what happens when the password is incorrect:
              xit 'returns a forbidden page if the password is incorrect' do
                response = get('/', password: 'junkpwd')
      
                expect(response.body).to include('Access forbidden!')
              end

    end


      # WEB APPS - Phase 3 - CH2 - Exercise: Test-drive and implement a GET /albums/:id route so it returns the HTML content for a single album:

      context "GET /albums/:id" do
        it 'should return info about album 2' do
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
    xit 'returns the list of albums as an HTML page' do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Albums</h1>')
      expect(response.body).to include('Title: Surfer Rosa')
      expect(response.body).to include('Released: 1988')
      expect(response.body).to include('Title: Waterloo')
      expect(response.body).to include('Released: 1974')
    end

    # Web App - Phase 3 - Ch3 - Using links
    it 'should have hyperlink to individual albums' do # skipping this as the following test has the ask for albums to be in HTML format.. 
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('a href="/albums/2">Surfer Rosa</a><br />')
      expect(response.body).to include('a href="/albums/3">Waterloo</a><br />')
      expect(response.body).to include('a href="/albums/4">Super Trouper</a><br />')
      expect(response.body).to include('a href="/albums/5">Bossanova</a><br />')
    end

  end

  # Web Apps - Phase 3 - Ch 4 - Using Forms:
  context 'GET /albums/new' do
    it 'should return the form to add a new album' do
      response = get('/albums/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/albums">')
      expect(response.body).to include('<input type="text" name="title" />')
      expect(response.body).to include('<input type="text" name="release_year" />')
      expect(response.body).to include('<input type="text" name="artist_id" />')

    end
  end


  # CH5 - Test-driving CRUD routes - Challenge - 1. Test-drive a route GET /artists, which returns the list of artists:
  context 'GET /artists' do
    xit 'should return the list of artists' do
      response = get('/artists')

      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
      # now implement this in sinatra => app.rb
    end

    # Phase 3 - Ch3 - Challenge: Test-drive a route GET /artists which returns an HTML page with the list of artists. 
    # This page should contain a link for each artist listed, linking to /artists/:id where :id needs to be the corresponding artist id.
    it 'should have hyperlink to individual artists' do # skipping this as the following test has the ask for albums to be in HTML format.. 
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('a href="/artists/2">ABBA</a><br />')
      expect(response.body).to include('a href="/artists/3">Taylor Swift</a><br />')
      expect(response.body).to include('a href="/artists/4">Nina Simone</a><br />')
      # expect(response.body).to include('a href="/artists/5">Wild nothing</a><br />')
    end

  end


      # Web Apps - Phase 3 - Ch4 - Challenge - Test-drive and implement a form page to add a new artist.
      context 'GET /artists/new' do
        it 'should return the form to add a new artist' do
          response = get('/artists/new')
    
          expect(response.status).to eq(200)
          expect(response.body).to include('<form method="POST" action="/artists">')
          expect(response.body).to include('<input type="text" name="name" />')
          expect(response.body).to include('<input type="text" name="genre" />')
    
        end
      end

  # Phase 3 - Ch3 - Challenge: Test-drive a route GET /artists/:id which returns an HTML page showing details for a single artist.
  context "GET /artists/:id" do
    it 'should return info about second artist' do
      response = get('artists/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>ABBA</h1>')
      expect(response.body).to include('ABBA')
      expect(response.body).to include('Genre: Pop')
    end
  end
  


  context "POST /albums" do

    # Phase 3 - Ch4 Using Forms - test being written:
    it 'should validate album parameters' do
      response = post(
        '/albums',
        invalid_artist_title: 'OK Computer',
        another_invalid_thing: 123
      )

      expect(response.status).to eq(400)
    end


    it 'should create a new album' do
      response = post('/albums', 
        title: 'OK Computer', 
        release_year: '1997', 
        artist_id: '1'
        )

      expect(response.status).to eq(200)
      expect(response.body).to eq('New album has been created.')
          # rspec => 
          # expected: 200
          # got: 404
          # now implement this in sinatra app.rb

          response = get('/albums')
          expect(response.body).to include('OK Computer')
    end
          # rspec
  end

    # CH5 - Test-driving CRUD routes - Challenge - 2. Test-drive a route POST /artists, which creates a new artist in the database. Your test should verify the new artist is returned in the response of GET /artists.
    context 'POST /artists' do

      # Phase 3 - Ch4 Using Forms - Challenge - Test-drive and implement a form page to add a new artist.
      it 'should validate artist parameters' do
        response = post(
          '/artists',
          invalid_artist_name: 'Sonu',
          another_invalid_thing: 123
        )

        expect(response.status).to eq(400)
      end

      it 'should create a new artist' do
        response = post('/artists', 
          name: 'Wild nothing', 
          genre: 'Indie'
          )
  
        expect(response.status).to eq(200)
        expect(response.body).to eq('New artist has been created.')
  
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
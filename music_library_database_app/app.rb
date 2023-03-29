# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

    # PHASE 3 - USING HTML TO CREATE WEBPAGES:
    get '/' do

      # return 'Hello'
        # @name = 'Shilpa' # to make this dynamic have this and call in .erb file
        # @cohort_name = 'Feb 2023' # to make this dynamic have this and call in .erb file

           @name = params[:name]

              # Now to have arrays and make them dynamic:
                @names = ['Harshita', 'Meghna', 'Rahul', 'Shilpa']

                # when we have condition like password:
                @password = params[:password]

      return erb(:index) # in reference to the views -> index.erb file we have just created
    end

    get '/albums' do
      repo = AlbumRepository.new
      albums = repo.all

      response = albums.map do |album| 
        album.title 
      end.join(', ')
        return response
            # Application
              # GET /albums
              # should return the list of albums
            # also, can chk on Postman:
            # rackup again and then Postman -> http://localhost:9292/albums => displays list all the albums
      end

      # Ch2 - implement a GET /albums/:id 
      get '/albums/:id' do
        repo = AlbumRepository.new
        @album = repo.find(params[:id])
  
        return erb(:album)
      end

      post '/albums' do
        repo = AlbumRepository.new
        new_album = Album.new
        new_album.title = params[:title]
        new_album.release_year = params[:release_year]
        new_album.artist_id = params[:artist_id]
      
        repo.create(new_album)
          return ''
              # rspec => also, can chk on Postman:
              # rackup again and then Postman ->Posts => http://localhost:9292/albums => body => form data => enter the Ok Computer and its details => sends => GET -> sends, shows new album, 'OK Computer'
        end

        # CH5 - Challenge - Test-drive a route GET /artists, which returns the list of artists:
        get '/artists' do
          repo = ArtistRepository.new
          artists = repo.all
        
          response = artists.map do |artist| 
            artist.name
          end.join(', ')
            return response
                # Application
                  # GET /albums
                  # should return the list of albums
                # also, can chk on Postman:
                # rackup again and then Postman -> GET =>  http://localhost:9292/artists => displays list all the artists => Pixies, ABBA, Taylor Swift, Nina Simone
          end

    # CH5 - Test-driving CRUD routes - Challenge - 2. Test-drive a route POST /artists, which creates a new artist in the database. Your test should verify the new artist is returned in the response of GET /artists.
          post '/artists' do
            repo = ArtistRepository.new
            new_artist = Artist.new
            # new_artist.id = params[:id]
            # puts "We are at line 67" # As Postman was not showing any EM, look at rackup log -> spotted a typo ArtistRepository
            # puts new_artist

            new_artist.name = params[:name]
            new_artist.genre = params[:genre]
          
            repo.create(new_artist)
              return ''
                  # rspec => also, can chk on Postman:
                  # rackup again and then Postman ->Posts => http://localhost:9292/albums => body => form data => enter the Ok Computer and its details => sends => GET -> sends, shows 'Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing'
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
#   GET /artists
#     should return the list of artists
#   POST /artists
#     should create a new artist (FAILED - 1)

# Failures:

#   1) Application POST /artists should create a new artist
#      Failure/Error: expect(response.status).to eq(200)
     
#        expected: 200
#             # got: 500 =========> 2023-03-28 12:13:12 - NameError - uninitialized constant Application::Artistepository
#             # Did you mean?  ArtistRepository:
     
#        (compared using ==)
#      # ./spec/integration/application_spec.rb:70:in `block (3 levels) in <top (required)>'

# Finished in 0.12996 seconds (files took 0.25988 seconds to load)
# 11 examples, 1 failure

# Failed examples:

# rspec ./spec/integration/application_spec.rb:63 # Application POST /artists should create a new artist

# ➜  music_library_database_app git:(main) ✗ 
# ➜  music_library_database_app git:(main) ✗ 
# ➜  music_library_database_app git:(main) ✗ 
# ➜  music_library_database_app git:(main) ✗ 
# ➜  music_library_database_app git:(main) ✗ 
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
#   GET /artists
#     should return the list of artists
#   POST /artists
# We are at line 67
# #<Artist:0x00000001474b4978>
#     should create a new artist

# Finished in 0.11371 seconds (files took 0.23784 seconds to load)
# 11 examples, 0 failures

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
#   GET /artists
#     should return the list of artists
#   POST /artists
#     should create a new artist

# Finished in 0.10939 seconds (files took 0.21351 seconds to load)
# 11 examples, 0 failures

# ➜  music_library_database_app git:(main) ✗   
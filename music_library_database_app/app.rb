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

    # get '/albums' do
    #   repo = AlbumRepository.new
    #   albums = repo.all

    #   response = albums.map do |album| 
    #     album.title 
    #   end.join(', ')
    #     return response
    #         # Application
    #           # GET /albums
    #           # should return the list of albums
    #         # also, can chk on Postman:
    #         # rackup again and then Postman -> http://localhost:9292/albums => displays list all the albums:
    #         # Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring, Ok Computer
    #   end


      # Phase 3 - Ch2 - implement a GET /albums/:id 
      get '/albums/:id' do
        repo = AlbumRepository.new
        artist_repo = ArtistRepository.new

        @album = repo.find(params[:id]) # finding the album first
        @artist = artist_repo.find(@album.artist_id) # Then finding the artist from artist_id from album
  
        return erb(:album)

                    # o/p: Dynamic albums results:
                    # http://localhost:9292/albums/1
                    # Ch2 - Test-drive and implement a GET /albums/:id route
                    # Doolittle
                    # Release year: 1989 Artist: Pixies
                      # http://localhost:9292/albums/7
                      # Ch2 - Test-drive and implement a GET /albums/:id route
                      # Folklore
                      # Release year: 2020 Artist: Taylor Swift

      end

      # Phase 3 - Ch2 - Challenge - list of albums as an HTML page
        get '/albums' do
          repo = AlbumRepository.new
    
          @album = repo.all
        
          return erb(:albums)
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

########
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
#   GET /
#     returns the html hello message with the given name
#     returns the html hello message with a different name
#     returns an html list of names
#     returns a hello page if the password is correct
#     returns a forbidden page if the password is incorrect
#   GET /albums/:id
#     should return info about album 1
#   GET /albums
#     should return the list of albums (PENDING: Temporarily skipped with xit)
#     returns the list of albums as an HTML page
#   POST /albums
#     should create a new album
#   GET /artists
#     should return the list of artists
#   POST /artists
#     should create a new artist

# Pending: (Failures listed here are expected and do not affect your suite's status)

#   1) Application GET /albums should return the list of albums
#      # Temporarily skipped with xit
#      # ./spec/integration/application_spec.rb:89


# Finished in 0.10628 seconds (files took 0.24604 seconds to load)
# 18 examples, 0 failures, 1 pending

##
# o/p for GET '/albums'
# Albums
# Title: Doolittle
# Released: 1989
# Title: Surfer Rosa
# Released: 1988
# Title: Waterloo
# Released: 1974
# Title: Super Trouper
# Released: 1980
# Title: Bossanova
# Released: 1990
# Title: Lover
# Released: 2019
# Title: Folklore
# Released: 2020
# Title: I Put a Spell on You
# Released: 1965
# Title: Baltimore
# Released: 1978
# Title: Here Comes the Sun
# Released: 1971
# Title: Fodder on My Wings
# Released: 1982
# Title: Ring Ring
# Released: 1973
# Title: Ok Computer
# Released: 1997
##
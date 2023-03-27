require 'sinatra/base'
# require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
#   configure :development do
    # register Sinatra::Reloader
#   end

    # GET
    # Root path (homepage, index page)
        # Testing for Ch3: test with rspec: (spec-> integration-> app_spec.rb)
    get '/' do
        return 'Hello!'
    end

    # get '/posts' do
    #     name = params[:name]
    #     cohort_name = params[:cohort_name]

    #     p name
    #     p cohort_name

    #     return "Hello #{name}, you are in the cohort #{cohort_name}."
                # o/p: Hello Shilpa, you are in the cohort Feb. 
    # end

    # post '/posts' do
    #     title = params[:title]

    #     return "Post was created with title: #{title}."
                # o/p: Post was created with title: Welcome to Makers.
    # end

    # Ch2 Building a Route - Exercise:
        # Request:
        # GET /hello?name=Leo

        # # Expected response (200 OK):
        # Hello Leo

        get '/hello' do
            name = params[:name]

            return "Hello #{name}"
                # Postman o/p: http://localhost:9292/hello?name=Leo
                        # Hello Leo
                # o/p: http://localhost:9292/hello?name=Anna
                        # Hello Anna
        end

    # Ch3 - Exercise:
    get '/names' do
        return "Julia, Mary, Karim"
    end
        # o/p:
        # GET /names
        # returns 'Julia, Mary, Karim'


        # Ch2 - challenge:
        post '/submit' do
            name = params[:name]
            message = params[:message]

            # return "Thanks #{name}, you sent this message: #{message}."
                # o/p: http://localhost:9292/submit
                # Post => Body => name -> Leo and another field message as "Hello world!"
                # Thanks Leo, you sent this message: "Hello world!".
                # and likewise for Shilpa for e.g

                # Ch 3 - Testing Routes with RSpec
                        #    expected: "Hello Dana"
                        #             got: "Thanks Dana, you sent this message: ."
                        
                        return "Hello #{name}"

                        #     Application
                        #     GET to /
                        #       returns 200 OK with the right content
                        #     POST to /submit
                        #       returns 200 OK with the right content
                        
                        #   Finished in 0.02033 seconds (files took 0.18459 seconds to load)
                        #   2 examples, 0 failures
        end


        # Ch3 - challenge:
        post '/sort-names' do
            names = "Joe,Alice,Zoe,Julia,Kieran"
            sort_names = names.split(",").sort.join(",")
        
            return sort_names
        end

end



# Routes

# GET / => to execute some code

# GET /todos/1 => execute some doifferent piece of code
    # Q': /todos/1 & /todos/12 => completed is false and true. 
    # Ans: It's just the underlying data that's used in the jsonplaceholder website - you can view the 
    # full raw data here: https://jsonplaceholder.typicode.com/todos

# POST /todos => execute some different code
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
    # get '/' do
    #     return 'Hello!'
    # end

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
                # o/p: http://localhost:9292/hello?name=Leo
                        # Hello Leo
                # o/p: http://localhost:9292/hello?name=Anna
                        # Hello Anna
        end

end



# Routes

# GET / => to execute some code

# GET /todos/1 => execute some doifferent piece of code
    # Q': /todos/1 & /todos/12 => completed is false and true. 
    # Ans: It's just the underlying data that's used in the jsonplaceholder website - you can view the 
    # full raw data here: https://jsonplaceholder.typicode.com/todos

# POST /todos => execute some different code
require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

    get '/tasks/new' do
        return erb(:new_task)
    end

    post '/tasks' do
        @task_name = params[:task_name]
        p @task_name

        return erb(:task_created)
    end

end
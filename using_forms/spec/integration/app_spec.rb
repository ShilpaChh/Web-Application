require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

    context 'GET /tasks/new' do
        it 'should return the html form to create a new task' do
            response = get('/tasks/new')

            expect(response.status).to eq(200)
            expect(response.body).to include('<form method="POST" action="/tasks">')
            expect(response.body).to include('<input type="text" name="task_name" />')
        end
    end

    context 'POST /tasks' do
        it 'should create task and return confirmation page' do
            response = post('/tasks', task_name: 'Buy Milk')

            expect(response.status).to eq(200)
            expect(response.body).to include('<h1>You saved task: Buy Milk</h1>')
        end

        it 'should create task and return confirmation page with different task' do
            response = post('/tasks', task_name: 'Cook Food')

            expect(response.status).to eq(200)
            expect(response.body).to include('<h1>You saved task: Cook Food</h1>')
        end

    end



end


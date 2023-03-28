# Ch3 - Test-driving a Route

# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do # we are simulating HTTP, with this Application, rspec would behave like a client
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # GET /:
  context "GET to /" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello!")
        # rspec => (no rackup reqd)
        #         Application
        #           GET to /
        #               returns 200 OK with the right content
    end
  end

  # get_hello_route_design_recipe being followed:
  context "GET /hello" do
    it "should return 'Hello Leo'" do
      response = get("/hello?name=Leo")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello Leo")
    end
  end
                    # my_web_server git:(main) ✗ rspec
                    # Application
                    # GET to /
                    #     returns 200 OK with the right content
                    # GET /hello
                    #     should return 'Hello Leo'
                    # GET /hello
                    #     should return 'Hello Anna' (PENDING: Temporarily skipped with xit)
                    # POST to /submit
                    #     returns 200 OK with the right content

                    # Pending: (Failures listed here are expected and do not affect your suite's status)

                    # 1) Application GET /hello should return 'Hello Anna'
                    #     # Temporarily skipped with xit
                    #     # ./spec/integration/app_spec.rb:45


                    # Finished in 0.01721 seconds (files took 0.15429 seconds to load)
                    # 4 examples, 0 failures, 1 pending

  # get_hello_route_design_recipe being followed:
  context "GET /hello" do
    it "should return 'Hello Anna'" do
      response = get("/hello?name=Anna")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello Anna")
    end
  end
                    # my_web_server git:(main) ✗ rspec
                    # Application
                    # GET to /
                    #     returns 200 OK with the right content
                    # GET /hello
                    #     should return 'Hello Leo'
                    # GET /hello
                    #     should return 'Hello Anna'
                    # POST to /submit
                    #     returns 200 OK with the right content

                    # Finished in 0.02053 seconds (files took 0.18242 seconds to load)
                    # 4 examples, 0 failures

    # Ch3 - Exercise:
    context "GET /names" do
        it "returns 'Julia, Mary, Karim'" do
            response = get("/names?names=Julia,Mary,Karim")
            expect(response.status).to eq 200
            expect(response.body).to eq 'Julia,Mary,Karim'
        end
    end
                                
  context "POST to /submit" do
    it "returns 200 OK with the right content" do
      # Send a POST request to /submit
      # with some body parameters
      # and returns a response object we can test.
      response = post("/submit", name: "Dana", some_other_param: 12)

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello Dana")
    end
  end

  context "POST to /sort-names" do
    it "returns comma-separated names" do
      # Send a POST request to /submit
      # with some body parameters
      # and returns a response object we can test.
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end

end




{{ METHOD }} {{ PATH}} Route Design Recipe
# Get /hello Route Design Recipe
Copy this design recipe template to test-drive a Sinatra route.

1. Design the Route Signature
You'll need to include:

    # Return a hello message:
the HTTP method: GET
the path: /hello
any query parameters (passed in the URL): name(string)
or body parameters (passed in the request body)

2. Design the Response
The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return 200 OK if the post exists, but 404 Not Found if the post is not found in the database.

Your response might return plain text, JSON, or HTML code.

Replace the below with your own design. Think of all the different possible responses your route will return.

<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->

<!-- <html>
  <head></head>
  <body>
    <h1>Post title</h1>
    <div>Post content</div>
  </body>
</html> -->

When query param 'name' is 'Leo'
...
Hello Leo!
...

When query param 'name' is 'Anna'
...
Hello Anna!
...

<!-- EXAMPLE -->
<!-- Response when the post is not found: 404 Not Found -->

<!-- <html>
  <head></head>
  <body>
    <h1>Sorry!</h1>
    <div>We couldn't find this post. Have a look at the homepage?</div>
  </body>
</html> -->

3. Write Examples
Replace these with your own design.

# Request 1:

GET /hello?name=Leo

# Expected response:

Hello Leo!

# Request 2:

GET /hello?name=Anna

# Expected response:

Hello Anna!

# Ch3 - Exercise:
    # Request:
    GET /names

    # Expected response (2OO OK):
    Julia, Mary, Karim

# Ch3 - Challenge
# Request:
    POST http://localhost:9292/sort-names

    # With body parameters:
    names=Joe,Alice,Zoe,Julia,Kieran

    # Expected response (sorted list of names):
    Alice,Joe,Julia,Kieran,Zoe



4. Encode as Tests Examples
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/posts?id=1')

      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
5. Implement the Route
Write the route and web server code to implement the route behaviour.
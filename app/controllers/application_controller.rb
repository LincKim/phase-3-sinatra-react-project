class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
   # @api: Enable CORS Headers
   configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get '/hello' do
    {message: 'Welcome to MemeGenerator'}.to_json
  end

   # @api: Format the json response
  def json_response(code: 200, data: nil)
    status = [200, 201].include?(code) ? "SUCCESS" : "FAILED"
    headers['Content-Type'] = 'application/json'
    if data
      [ code, { data: data, message: status }.to_json ]
    end
  end

  # @method: Add a new MEME to the DB
  post '/meme/create' do
    begin
        meme = Meme.create( self.data(create: true) )
        json_response(code: 201, data: meme)
    rescue => e
        json_response(code: 422, data: { error: e.message })
    end
end



   # @helper: not found error formatter
   def not_found_response
    json_response(code: 404, data: { error: "You seem lost. That route does not exist." })
  end

  # @api: 404 handler
  not_found do
    not_found_response
  end

end

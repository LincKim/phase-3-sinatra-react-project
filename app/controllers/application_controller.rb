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
  
  post '/memes/create' do
    # puts params.inspect
    data = JSON.parse(request.body.read)
      begin
          memes = Meme.create(data)
          json_response(code: 201, data: memes)
          memes.to_json
      rescue => e
          json_response(code: 422, data: { error: e.message })
        #   memes.to_json
      end       
    end


    # @method: Display all memes
  get '/memes' do
      meme = Meme.all
      meme.to_json
  end

  put '/memes/update/:id' do
    data = JSON.parse(request.body.read)
      begin
          memes = Meme.find(params[:id].to_i)
          memes.update(data)
          json_response(data: { message: "memes updated successfully" })
          memes.to_json
      rescue => e
          json_response(code: 422 ,data: { error: e.message })
      end
  end

  get '/memes/search' do
    query = params[:query]
    memes = Meme.select{ |meme| meme[:top_text].include?(query) || meme[:date].to_s.include?(query) }
    memes.to_json
  end

  delete '/memes/:id' do
    begin
      meme = Meme.find(params[:id])
      meme.destroy
      json_response(data: { message: "Meme deleted successfully" })
      meme.to_json
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

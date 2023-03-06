# app/controllers/users_controller.rb
class UsersController < ApplicationController

  
    #@method: create a new user
    post '/auth/signup' do
      begin
        data = JSON.parse(request.body.read)
        users = User.create(data)
        users.to_json
      rescue => e
          error_response(422, e)
      end
  end
  
  post '/auth/login' do
    request.body.rewind
    request_payload = JSON.parse(request.body.read)
    email = request_payload['email']
    password = request_payload['password']
    user = User.find{ |u| u[:email] == email && u[:password] == password }
    if user
      {message: "Login success!"}.to_json
    else
      {message: "Invalid email or password"}.to_json
    end
  end
     
  end
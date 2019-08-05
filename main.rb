
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'database_config'
require_relative 'models/comment'
require_relative 'models/pier'
require_relative 'models/user'
require_relative 'models/photo'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user 
  end
end


get '/' do
  @piers = Pier.all
  erb :index
end


get '/piers/:id' do 
  @pier = Pier.find(params[:id])
  @comments = Comment.where(pier_id: params[:id]) 
  @photos = Photo.all
  erb :show
end


get '/login' do
  erb :login
end


post "/sessions" do 
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id #session belongs to sinatra!Do not change it.
    redirect '/'
  else 
    erb :login
  end
end


get '/sign_up' do 
  erb :sign_up
end


post "/users" do
  user = User.new 
  user.email = params[:email]
  user.password = params[:password]
  user.username = params[:username]
  user.save
  session[:user_id] = user.id  
  redirect '/'
end


delete '/sessions' do
  session[:user_id] = nil
  redirect '/'
end


get '/my_account' do
@piers = Pier.where(user_id: current_user.id)
@comments = Comment.where(user_id: current_user.id) 
@photos = Photo.where(user_id:current_user.id)
erb :my_account
end


post '/comments' do 
  redirect '/login' if session[:user_id]== nil
  comment = Comment.new
  comment.body = params[:body]
  comment.user_id = current_user.id
  comment.pier_id = params[:pier_id]
  comment.save
  redirect "/piers/#{params[:pier_id]}"  
end

delete '/my_account' do
  comment = Comment.find(params[:id])
  comment.destroy
  redirect '/my_account'
end


post '/photos' do 
  redirect '/login' if session[:user_id]== nil
  photo = Photo.new
  photo.user_id = current_user.id
  photo.pier_id = params[:pier_id]
  photo.image_url = params[:image_url]
  photo.save
  redirect "/piers/#{params[:pier_id]}"
end


delete '/my_account' do
  photo = Photo.find(params[:id])
  photo.destroy
  redirect '/my_account'
end








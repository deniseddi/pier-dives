require 'pry'   
require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'database_config'
require_relative 'models/comment'
require_relative 'models/pier'
require_relative 'models/user'
require_relative 'models/photo'

## current user id error NilClass - Are you logged in ??

enable :sessions

#helpers make methods available (also in templates)
helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user #is truthy?
  end
end

get '/' do
  @piers = Pier.all
  erb :index
end

get '/piers/:id' do #this is the route that calls show! @ comments was not here and I was getting error method id message
  @pier = Pier.find(params[:id])
  # @paragraph_1 = Pier.find
  @comments = Comment.all 
  @photos = Photo.all
  erb :show
end


get '/login' do
  erb :login
end


post "/sessions" do 
  #1.look up for user with email record in our table 
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
  #create a session? below?Yes. When you login you create a session and when you signup you also create a session. so you need this line on both.
    session[:user_id] = user.id #session belongs to sinatra!Do not change it.
    redirect '/'
  else #elsif ?falsey login/ else sign in ?
    #if falsey, wrong email or password
    erb :login
  end
end


get '/sign_up' do 
  erb :sign_up
end


post "/users" do
  #create users 
  user = User.new 
  user.email = params[:email]
  user.password = params[:password]
  user.username = params[:username]
  user.save
  #log in new user into session
  session[:user_id] = user.id  
  redirect '/'
end


delete '/sessions' do
  #1.destroy the session
  session[:user_id] = nil
  #2.redirect
  redirect '/'
end



###check
get '/my_account' do
@piers = Pier.where(user_id: current_user.id)
@comments = Comment.where(user_id: current_user.id) 
@photos = Photo.where(user_id:current_user.id)
# @user = session[:user_id]
erb :my_account
end

####check with Kasun
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

#check
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








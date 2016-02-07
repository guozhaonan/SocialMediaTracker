#This is where the gems are being required, all of these gems are vital in the use of the current application
#Allows use of rubygems
require 'rubygems'
#Allows use of the Ruby Framework, Sinatra, a DSL for creating Web Applications in Ruby
require 'sinatra'
#Explicit declaration of Erubis, recommended by Sinatra
require 'tilt/erubis'
#Allows use of Instagram API via the Instagram Ruby Gem
require 'instagram'
#Allows use of Alchemy API's Sentiment Analysis tool
require 'alchemy_api'

# Implicit definition of Instagram API Authentication
# For Security purposes, these are usually kept private via a gitignore file but for the sake of this project and in the interest of time, this will be how we initialize our authentication variables
Instagram.configure do |config|
  config.client_id = "58c987f84dee4041884e7d3e51b76589"
  config.access_token = "356056384.1fb234f.75f3ba8ced3b4ea1968f8e77f1b178d4 "
end
AlchemyAPI.configure do |config|
  config.apikey = "c302172761ec964f90445694a4ace8e159726fe7"
end

#Sinatra Routes

get '/' do
  #This will be the first step in the application, introduces how to use the application and how Sentiment Analysis is important in making Tint a better product.
  erb :intro
end
#This route is where the Instgram API is being called
get '/:keyword' do
  #This is declaration of the parameter "keyword" as the input for the Instagram API, input in a keyword and the API will search for media related to this singular tag
  keyword = params[:keyword].to_s
  #This is the declaraion of the tag searching method
  #Returns not only the information on the search tag but also related tags
  #Used to search the Instagram API for recent media regarding the original tag and for creating links to the related tags
  @tags = Instagram.tag_search(keyword)
  #Declaration of the most recent posts regarding the searched tag
  @instagram = Instagram.tag_recent_media(@tags[0]["name"], count: 30)
  #This is where the view for the display of Instagram posts with sentiment analysis scores is being declared
  erb :app
end
get '/post/:id' do

id = params[:id]

@instagram_post = Instagram.media_item(id)

erb :picture
end

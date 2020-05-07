require "sinatra"
require "sinatra/reloader" if development?

get "/search" do
  erb :search
end
require 'sinatra'
require 'sinatra/reloader'
require 'lazyrecord'


use Rack::MethodOverride


delete '/delete-book/:id' do
  id = params[:id].to_i
  Book.delete(id)
  redirect '/'
end














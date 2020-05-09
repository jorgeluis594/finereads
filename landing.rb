# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'


get '/' do
  @title = 'asd'
  erb :landing , layout: :layout
end


# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative 'model/googleapi'


get '/list-books' do
  book_data = Book.list
  # google_api_obj = GoogleData(book_data)
  locals = {img: ':v', title: '', author: '', status: '', date_added: ''}
  erb :list_books, layout: :layout, locals: locals
end


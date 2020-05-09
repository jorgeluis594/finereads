# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative 'model/googleapi'
require_relative 'model/books'


get '/list-books' do
  books_data = Book.all.map do |book|
    GoogleData.new('_eCcGXRAnvwC').clean_obj_list(book.status, 'May 06, 2020 (This is static)', book.id)
  end
  erb :list_books, layout: :layout, locals: {books: books_data}
end


require "sinatra"
require "sinatra/reloader" if development?
require_relative 'model/googleapi'
require_relative 'helpers/noimage'
require_relative 'helpers/status'
require_relative 'model/books'
helpers NoNil, Status

get "/search" do
  book=params["searchbook"].split(' ').join('+') rescue  nil
  params["page"] ? count = 2 : count = 1
  book && book != "" ? books = BooksApi::search_book(book,count) : books = nil
  erb :search, locals: { books: books, search: book, page: count }
end

post "/book/register/" do
  id_goolge = params["id_google"]
  status = params["status"]
  Book.new(id_goolge,status).save
  redirect url("/search")
end
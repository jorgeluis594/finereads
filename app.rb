require "sinatra"
require "sinatra/reloader" if development?
require "lazyrecord"
require "http"
require_relative "model/books"
require_relative 'model/googleapi'
require_relative 'helpers/helpers_utils'

helpers NoNil, Status, HtmlHelper


get "/books/:book_id" do
  @book_info = GoogleData.new(params["book_id"])
  @book_info.load_data
  erb :details
end

get "/books/:book_id/edit" do
  @book_info = GoogleData.new(params["book_id"])
  @book_info.load_data
  info_saved_byidbook = Book.all.filter { |obj| obj.id_google == params["book_id"] }
  @current_status = info_saved_byidbook[0].status
  @current_notes = info_saved_byidbook[0].notes
  erb :edit
end

post "/books/:book_id/edit" do
  @book_save = Book.all.find { |obj| obj.id_google == params["book_id"] }
  @book_save.notes = params["notes"]
  @book_save.status = params["status"]
  @book_save.save
  redirect url("/search") #Colocar ruta a la lista de libros
end

get "/search" do
  book = params["searchbook"].split(' ').join('+') rescue nil
  params["page"] ? count = 2 : count = 1
  book && book != "" ? books = BooksApi::search_book(book, count) : books = nil
  erb :search, locals: {books: books, search: book, page: count}
end

post "/book/register/" do
  id_goolge = params["id_google"]
  status = params["status"]
  Book.new(id_goolge, status).save
  redirect url("/search")
end

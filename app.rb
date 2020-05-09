require "sinatra"
require "sinatra/reloader" if development?
require_relative "model/books"
require_relative 'model/googleapi'
require_relative 'helpers/helpers_utils'

helpers NoNil, Status, HtmlHelper

get "/" do
  @title = 'asd'
  erb :landing, layout: :layout
end

get "/search" do
  book = params["searchbook"].split(' ').join('+') rescue nil
  params["page"] ? count = 2 : count = 1
  book && book != "" ? books = GoogleData.search_book(book, count) : books = nil
  erb :search, locals: {books: books, search: book, page: count}
end

post "/book/register/" do
  id_goolge = params["id_google"]
  status = params["status"]
  Book.new(id_goolge, status).save
  redirect url("/list-books/")
end

get "/books/:book_id" do
  @book_info = GoogleData.new(params["book_id"])
  @book_info.load_data
  erb :details
end

get "/books/:book_id/edit" do
  info_saved_byidbook = Book.all.filter { |obj| obj.id == params["book_id"].to_i }
  @book_info = GoogleData.new(info_saved_byidbook[0].id_google)
  @book_info.load_data
  @current_status = info_saved_byidbook[0].status
  @current_notes = info_saved_byidbook[0].notes
  erb :edit
end

post "/books/:book_id/edit" do
  book_save = Book.all.find { |obj| obj.id == params["book_id"].to_i }
  book_save.notes = params["notes"]
  book_save.status = params["status"]
  book_save.save
  redirect url("/list-books/")
end

get '/list-books/' do
  books_data = Book.all.map do |book|
    GoogleData.new(book.id_google).clean_obj_list(book.status, book.date, book.id)
  end
  erb :list_books, layout: :layout, locals: {books: books_data}
end

use Rack::MethodOverride


delete '/delete-book/:id' do
  id = params[:id].to_i
  Book.delete(id)
  redirect '/list-books/'
end




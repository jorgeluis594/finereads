require "sinatra"
require "sinatra/reloader" if development?
require "lazyrecord"
require "http"
require_relative "model/books"

class GoogleData
  attr_accessor :data
  def initialize(id_google)
    @id_google = id_google
  end

  def load_data
    @data = HTTP.get("https://www.googleapis.com/books/v1/volumes/#{@id_google}").parse
  end

  def title
    @data["volumeInfo"]["title"]
  end

  def image
    @data["volumeInfo"]["imageLinks"]["smallThumbnail"]
  end

  def subtitle
    @data["volumeInfo"]["subtitle"]
  end

  def description
    @data["volumeInfo"]["description"]
  end

  def author
    @data["volumeInfo"]["authors"].join
  end

  def price
    @data["saleInfo"]["listPrice"]["amount"].to_s << " " << @data["saleInfo"]["listPrice"]["currencyCode"]
  end

  def play_store
    @data["volumeInfo"]["infoLink"]
  end
end

helpers do
  def html_option(value, label, current_value)
    selected = value == current_value
    "<option value=\"#{value}\" #{"selected" if selected}>#{label}</option>"
  end
end


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

require 'http'
require 'sinatra'
require 'sinatra/reloader'

url = 'https://www.googleapis.com/books/v1/volumes?q=search'
api_request = HTTP.headers(accept: 'application/json').get(url).parse
item_api = api_request['items'][0]

get '/edit-book/' do
  data = item_api['volumeInfo']
  img_link = data['imageLinks']['thumbnail']
  default_img = 'https://www.esimob.com/user/images/esimob_pic_default.jpg'
  img_link.nil? ? img_link=default_img : img_link
  @img_link = img_link
  @book_title = data['title']
  @book_author = data['authors'].join(', ') + '.'
  @book_note = 'asdasdasd'
  erb :edit_book, layout: :layout
end

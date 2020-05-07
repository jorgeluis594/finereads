require 'http'
require 'sinatra'
require 'sinatra/reloader'

url = 'https://www.googleapis.com/books/v1/volumes?q=search'
api_request = HTTP.headers(accept: 'application/json').get(url).parse
item_api = api_request['items'][0]

get '/edit-book/' do
  data = item_api['volumeInfo']
  @img_link = data['imageLinks']['thumbnail']
  @book_title = data['title']
  @book_author = data['authors'].join(', ') + '.'
  @book_note = 'asdasdasd'
  erb :edit_book, layout: :layout
end
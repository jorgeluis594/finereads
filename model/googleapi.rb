require 'http'
require 'json'
module BooksApi
  BOOKSURL = "https://www.googleapis.com/books/v1/volumes?q="

  def self.search_book(book, number_page)
    if number_page == 1
      api_book(book,1,8)
    elsif number_page == 2
      api_book(book,9,40)
    else
      raise 'Page number incorrect'
    end
  end

  def self.api_book (book,index,count)
    book.is_a?(String) ? JSON.parse(HTTP.get("#{BOOKSURL}#{book}&startIndex=#{index}&maxResults=#{count}"))["items"] : raise
  end

  private_class_method :api_book
end

require "http"
require "json"
BOOKSURL = "https://www.googleapis.com/books/v1/volumes?q=".freeze

class GoogleData
  attr_accessor :data, :sales_info

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
    @data["volumeInfo"]["subtitle"].nil? ? "" : @data["volumeInfo"]["subtitle"]
  end

  def description
    @data["volumeInfo"]["description"].nil? ? "No description" : @data["volumeInfo"]["description"]
  end

  def author
    @data["volumeInfo"]["authors"].nil? ? "No Author/s" : @data["volumeInfo"]["authors"].join(", ") + "."
  end

  def price
    @sales_info = @data.fetch("saleInfo", {})
    if sales_info["listPrice"].nil?
      "Don't Know" 
    else 
      @sales_info["listPrice"]["amount"].to_s << " " << @sales_info["listPrice"]["currencyCode"]
    end
  end

  def play_store
    @data["volumeInfo"]["infoLink"].nil? ? "#" : @data["volumeInfo"]["infoLink"]
  end

  def self.search_book(book, number_page)
    if number_page == 1
      api_book(book, 1, 8)
    elsif number_page == 2
      api_book(book, 9, 40)
    else
      raise "Page number incorrect"
    end
  end

  def self.api_book(book, index, count)
    book.is_a?(String) ? JSON.parse(HTTP.get("#{BOOKSURL}#{book}&startIndex=#{index}&maxResults=#{count}"))["items"] : raise
  end
end



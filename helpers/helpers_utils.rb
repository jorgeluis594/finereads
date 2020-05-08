require_relative '../model/books'

module NoNil
  def image?(book)
    book["volumeInfo"]["imageLinks"]["thumbnail"] rescue "/images/noimage.png"
  end

  def value_search(search)
    search ? search.split('+').join(' ') : nil
  end
end

module Status
  def want
    StatusBook::WANT
  end

  def read
    StatusBook::READ
  end

  def reading
    StatusBook::READING
  end
end

module HtmlHelper
  def html_option(value, label, current_value)
    selected = value == current_value
    "<option value=\"#{value}\" #{"selected" if selected}>#{label}</option>"
  end
end
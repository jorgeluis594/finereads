module NoNil
  def image? (book)
    book["volumeInfo"]["imageLinks"]["thumbnail"] rescue "/images/noimage.png"
  end
  def value_search(search)
    search ? search.split('+').join(' ') : nil
  end
end
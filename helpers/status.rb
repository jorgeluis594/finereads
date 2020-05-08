require_relative '../model/books'
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
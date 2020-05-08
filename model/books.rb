require 'lazyrecord'
module StatusBook
  READ = "Read"
  READING = "Reading"
  WANT = "Want to read"
end
class Book < LazyRecord

  attr_reader :id_google

  def initialize (id_google, status = StatusBook::WANT, notes = "")
    @id_google = id_google
    @status = status
    @notes = notes
  end


end
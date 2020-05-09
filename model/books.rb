require "lazyrecord"
module StatusBook
  READ = "Read"
  READING = "Reading"
  WANT = "Want to read"
end
class Book < LazyRecord
  attr_accessor :id_google, :status, :notes
  def initialize(id_google, status = StatusBook::WANT, notes = "")
    @id_google = id_google
    @status = status
    @notes = notes
    @date = Time.now
  end
end


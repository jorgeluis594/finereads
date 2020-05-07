require 'lazyrecord'
status_choices = %w[read reading want_to_read]

class Book < LazyRecord
  def initialize(id:, status:, note:)
    @id = id
    @status = status
    @note = note
  end
end
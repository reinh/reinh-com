class OrderedHash < Array #:nodoc:
  def []=(key, value)
    if pair = assoc(key)
      pair.pop
      pair << value
    else
      self << [key, value]
    end
  end

  def [](key)
    pair = assoc(key)
    pair ? pair.last : nil
  end

  def keys
    collect { |key, value| key }
  end

  def values
    collect { |key, value| value }
  end
end

# from ActiveSupport
module Enumerable
  # Collect an enumerable into sets, grouped by the result of a block. Useful,
  # for example, for grouping records by date.
  #
  # e.g. 
  #
  #   latest_transcripts.group_by(&:day).each do |day, transcripts| 
  #     p "#{day} -> #{transcripts.map(&:class) * ', '}"
  #   end
  #   "2006-03-01 -> Transcript"
  #   "2006-02-28 -> Transcript"
  #   "2006-02-27 -> Transcript, Transcript"
  #   "2006-02-26 -> Transcript, Transcript"
  #   "2006-02-25 -> Transcript"
  #   "2006-02-24 -> Transcript, Transcript"
  #   "2006-02-23 -> Transcript"
  def group_by
    inject OrderedHash.new do |grouped, element|
      (grouped[yield(element)] ||= []) << element
      grouped
    end
  end if RUBY_VERSION < '1.9'

end

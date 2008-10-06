module Enumerable
  # Collect an enumerable into sets, grouped by the result of a block. Useful,
  # for example, for grouping records by date.
  #
  # Example:
  #
  # latest_transcripts.group_by(&:day).each do |day, transcripts|
  # p "#{day} -> #{transcripts.map(&:class).join(', ')}"
  # end
  # "2006-03-01 -> Transcript"
  # "2006-02-28 -> Transcript"
  # "2006-02-27 -> Transcript, Transcript"
  # "2006-02-26 -> Transcript, Transcript"
  # "2006-02-25 -> Transcript"
  # "2006-02-24 -> Transcript, Transcript"
  # "2006-02-23 -> Transcript"
  def group_by
    assoc = {}
 
    each do |element|
      key = yield(element)
 
      if assoc.has_key?(key)
        assoc[key] << element
      else
        assoc[key] = [element]
      end
    end
 
    assoc
  end
end
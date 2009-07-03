class Array
  def unique_by
    inject(Hash.new(0)) do |h, i|
      h[yield(i)] += 1
      h
    end.size == size
  end
end

class String
  # Converts a string to something usable as a url slug
  def slugify
    self.downcase.gsub(/\W|_/, ' ').strip.squeeze(' ').gsub(/\s/, '-')
  end
end
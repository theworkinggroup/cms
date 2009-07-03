class String
  # Converts a string to something usable as a url slug
  def slugify
    self.downcase.gsub(/\W|_/, ' ').strip.squeeze(' ').gsub(/\s/, '-')
  end
end
class Array
  def unique_by
    inject(Hash.new(0)) do |h, i|
      h[yield(i)] += 1
      h
    end.size == size
  end
end
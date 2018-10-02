class Set
  attr_reader :value, :length

  def initialize(value, length)
    @value = value
    @length = length
  end

  def single?
    length == 1
  end

  def pair?
    length == 2
  end

  def trip?
    length == 3
  end

  def quad?
    length == 4
  end
end

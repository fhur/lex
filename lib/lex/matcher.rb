class Matcher

  attr_reader :identifier

  def initialize(identifier)
    @identifier = identifier
  end

  def match(code)
    return false
  end

end

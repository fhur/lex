require 'lex/matcher'

class RegexMatcher < Matcher

  attr_reader :regex

  def initialize(identifier, regex)
    super(identifier)
    @regex = regex
  end

  def match(code)
    match = code[@regex, 1]
    if match
      return [@identifier, match]
    else
      return nil
    end
  end

  def self.create(*matchers)
    return matchers.map do |matcher|
      RegexMatcher.new(matcher[0], matcher[1])
    end
  end

end

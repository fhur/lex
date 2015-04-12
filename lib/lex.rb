require 'lex/matcher'
require 'lex/regex_matcher'

class Lex

  attr_accessor :matchers

  def initialize(*matchers)
    @matchers = RegexMatcher.create(*matchers)
  end

  def tokenize(code)
    code.chomp!
    tokens = [] # every token is a [:name, :value] pair
    i = 0 # hold the current index
    while i < code.size
      chunk = code[i..-1]

      # find a match
      token = find_match(chunk, @matchers)

      # there should always be a match
      if token == nil
        raise "Unable to match #{chunk} at index #{i}"
      end

      tokens << token unless ignorable?(token)

      i += token[1].size
    end

    return tokens
  end

  # find a match or nil if no match is found
  def find_match(chunk, matchers)
    matchers.each do |matcher|
      match = matcher.match(chunk)
      return match if match
    end
    return nil
  end

  def ignorable?(token)
    token[0] == :ignore || token[0] == :ignored
  end
end

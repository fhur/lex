require 'minitest/autorun'
require 'lex'

describe Lex do

  describe 'constructor' do
    it 'should initialize the lexer with a list of RegexMatchers' do
      lex = Lex.new([:A, /A/], [:B, /B/])

      matchers = lex.matchers
      matchers.size.must_equal 2
      matchers.first.identifier.must_equal :A
      matchers.first.regex.must_equal(/A/)
    end

    it 'should initialize with empty matcher list if no args' do
      lex = Lex.new
      lex.matchers.must_equal []
    end
  end

  describe "A simple calculator lexer" do

    before :each do
      @lex = Lex.new(
        [:OPERATOR, /\A(\+|-|\*|\/)/],
        [:NUMBER, /\A([0-9]+)/],
        [:LPARENS, /\A(\()/],
        [:RPARENS, /\A(\))/],
        [:ignore, /\A( )/],
        [:ignore, /\A(\\n)/]
      )
    end

    it 'should contain 6 matchers' do
      @lex.matchers.size.must_equal 6
    end

    it 'should recognize a simple add operation' do
      tokens = @lex.tokenize("5 + 6")
      tokens.must_equal [
        [:NUMBER, "5"],
        [:OPERATOR, "+"],
        [:NUMBER, "6"]
      ]
    end

    it 'should ignore ":ignore" tokens' do
      tokens = @lex.tokenize(" 5    +  6 ")
      tokens.must_equal [
        [:NUMBER, "5"],
        [:OPERATOR, "+"],
        [:NUMBER, "6"]
      ]
    end

    it 'should recognize multiple operators'do
      tokens = @lex.tokenize("5 + 3 * 2 - 1")
      tokens.must_equal [
        [:NUMBER, "5"],
        [:OPERATOR, "+"],
        [:NUMBER, "3"],
        [:OPERATOR, "*"],
        [:NUMBER, "2"],
        [:OPERATOR, "-"],
        [:NUMBER, "1"],
      ]
    end

  end
end

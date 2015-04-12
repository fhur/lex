require 'minitest/autorun'
require 'lex/regex_matcher'

describe RegexMatcher do


  describe "create" do
    it "returns a list of RegexMatcher" do
      list = RegexMatcher.create(
        [:ID, /\A(a)/],
        [:FOO, /\A(b)/],
        [:BAR, /\A(c)/],
        [:BAZ, /\A(d)/],
      )
      list.size.must_equal 4
      list.first.identifier.must_equal :ID
      list.first.regex.must_equal(/\A(a)/)
      list.last.identifier.must_equal :BAZ
      list.last.regex.must_equal(/\A(d)/)
    end

    it "returns an empty array when no params are passed" do
      list = RegexMatcher.create()
      list.must_equal []
    end
  end

  describe 'match' do
    it 'should return nil if there is no match' do
      matcher = RegexMatcher.new :foo, /\A(asdjkfh)/
      match = matcher.match("lolo")
      match.must_equal nil
    end

    it 'should returned the matched text if there is a match' do
      matcher = RegexMatcher.new :foo, /\A(asd)/
      match = matcher.match("asdfasdf")
      match.must_equal [:foo, "asd"]
    end
  end

  describe 'constructor' do
    it 'should initialize fields' do
      id = :foobasd
      regex = /asdkjfh93/
      matcher = RegexMatcher.new(id, regex)
      matcher.identifier.must_equal id
      matcher.regex.must_equal regex
    end

  end

end

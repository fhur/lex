= lex

A simple utility class for creating lexers with only a couple of lines
of code.

== Usage

Add the gem to your Gemfile or `gem install lex`

Create a new `Lex` instance and pass a list of arguments describing
tokens:

```ruby
lex = Lex.new(
  [:NUMBER, /\A([0-9]+)/],
  [:OPERATOR, /\A(\+|\*|-|\/)/],
  [:ignore, /\A( )/],
)
```

That will create a lexer that matches 3 different types of tokens,
namely numbers, operators and whitespace. If a token matcher has
`:ignore` as it's identifier, tokens matched with that regex will be
ignored in the final output.

==== Tokenizing

Let's run the lexer on a simple program

```ruby
lex.tokenize("5 + 3 *     2")
# the output will be
# [
#   [:NUMBER,"5"],
#   [:OPERATOR,"+"],
#   [:NUMBER,"3"],
#   [:OPERATOR,"*"],
#   [:NUMBER,"2"],
# ]
```

== Contributing to lex

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2015 fhur. See LICENSE.txt for
further details.


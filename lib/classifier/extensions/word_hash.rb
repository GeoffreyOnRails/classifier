# Author::    Lucas Carlson  (mailto:lucas@rufy.com)
# Copyright:: Copyright (c) 2005 Lucas Carlson
# License::   LGPL

# These are extensions to the String class to provide convenience
# methods for the Classifier package.
class String
  #Skip words by default
  @corpus_skip_words = [
  "a",
  "again",
  "all",
  "along",
  "are",
  "also",
  "an",
  "and",
  "as",
  "at",
  "but",
  "by",
  "came",
  "can",
  "cant",
  "couldnt",
  "did",
  "didn",
  "didnt",
  "do",
  "doesnt",
  "dont",
  "ever",
  "first",
  "from",
  "have",
  "her",
  "here",
  "him",
  "how",
  "i",
  "if",
  "in",
  "into",
  "is",
  "isnt",
  "it",
  "itll",
  "just",
  "last",
  "least",
  "like",
  "most",
  "my",
  "new",
  "no",
  "not",
  "now",
  "of",
  "on",
  "or",
  "should",
  "sinc",
  "so",
  "some",
  "th",
  "than",
  "this",
  "that",
  "the",
  "their",
  "then",
  "those",
  "to",
  "told",
  "too",
  "true",
  "try",
  "until",
  "url",
  "us",
  "were",
  "when",
  "whether",
  "while",
  "with",
  "within",
  "yes",
  "you",
  "youll",
  ]
  # Removes common punctuation symbols, returning a new string.
  # E.g.,
  #   "Hello (greeting's), with {braces} < >...?".without_punctuation
  #   => "Hello  greetings   with  braces         "
  def without_punctuation
    tr( ',?.!;:"@#$%^&*()_=+[]{}\|<>/`~', " " ) .tr( "'\-", "")
  end

  # Removes figures, returning a new string.

  def without_figures
    tr('1234567890', "")
    #TODO
  end

  # Return a Hash of strings => ints. Each word in the string is stemmed,
  # interned, and indexes to its frequency in the document.
  def word_hash
    word_hash_for_words(gsub(/[^\w\s]/,"").split + gsub(/[\w]/," ").split)
  end

  # Return a word hash without extra punctuation or short symbols, just stemmed words
  def clean_word_hash
    word_hash_for_words gsub(/[^\w\s]/,"").split
  end

  #Remove all the skip words
  def clean_skip_words
    @corpus_skip_words = []
  end

  #Puts the array received as the new skip words list
  #WARNING : This method erase every skip words previously loaded!
  def set_skip_words array
    @corpus_skip_words = array
  end

  #Add a new skip word to the list of skip words
  def add_skip_word word
    @corpus_skip_words = word
  end

  private

  def word_hash_for_words(words)
    d = Hash.new
    words.each do |word|
      word.downcase! if word =~ /[\w]+/
      key = word.stem.intern
      if word =~ /[^\w]/ || ! @corpus_skip_words.include?(word) && word.length > 2
        d[key] ||= 0
        d[key] += 1
      end
    end
    return d
  end
end

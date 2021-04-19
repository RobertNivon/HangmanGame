class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
    
  def word
      return @word
  end
    
  def guesses
      return @guesses
  end
    
  def wrong_guesses
      return @wrong_guesses
  end
   
  def guess(letter)
      if letter == nil
          raise ArgumentError
      elsif letter == ""
          raise ArgumentError
      elsif !letter.match?(/[a-z,A-Z]/)
          raise ArgumentError
      end
      
      letter = letter.downcase
      
      if @guesses.include?(letter) || @wrong_guesses.include?(letter)
          return false
      end
      
      if @word.include? letter
          @guesses += letter
          return true
      else 
          @wrong_guesses += letter
          return true
      end
  end
    
  def word_with_guesses
      tmp = ""
      @word.each_char do |c|
          if @guesses.include? c
              tmp += c
          else
              tmp += "-"
          end
      end
      return tmp
  end  
    
  def check_win_or_lose
      if @word == word_with_guesses
          return :win
      elsif @wrong_guesses.length >= 7
          return :lose
      else
          return :play
      end
  end
      
      
  

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

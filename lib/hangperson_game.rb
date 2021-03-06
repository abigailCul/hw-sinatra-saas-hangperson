class HangpersonGame
  attr_accessor :word , :guesses , :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess character
    
  if character.nil? or /[^A-Za-z]/.match(character) != nil or character == ''
		raise ArgumentError.new("Not a valid letter")
	end
  
  character.downcase!
  
	if @guesses.include? character or @wrong_guesses.include? character
		return false
	end
  
		if @word.include? character
  		@guesses = @guesses + character
  		return true
	else
		@wrong_guesses = @wrong_guesses + character
		return true
  end
  
  end
  
  def word_with_guesses
    result = ''
    @word.split('').each do |char|
      if @guesses.include? char
        result << char
      else
        result << '-'
      end
    end
    
    return result
  end
  
  def check_win_or_lose
    if word_with_guesses.downcase == @word.downcase
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

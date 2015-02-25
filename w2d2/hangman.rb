require 'byebug'

class Game
  attr_reader :revealed_word

  MAX_TURNS = 10

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def init_word
    length = @checking_player.set_word_length
    @revealed_word = Array.new(length, '_')
    @guessing_player.initialize_on_word(length, @revealed_word)
  end

  def display
    puts @revealed_word.join(' ')
  end

  def update_revealed_word(idxs, current_guess)
    idxs.each do |i|
      @revealed_word[i] = current_guess
    end
    @guessing_player.revealed_word = @revealed_word
  end

  def play
    init_word

    end_message = "Justice prevails! Tonight the crows shall feast."

    MAX_TURNS.times do
      display
      begin
        current_guess = @guessing_player.guess
      rescue ArgumentError.new => e
        puts e
        retry
      end

      idxs = @checking_player.check_guess(current_guess)
      update_revealed_word(idxs, current_guess)
      if @revealed_word.none? { |c| c == '_' }
        end_message = "#{@revealed_word.join(' ')}\n"\
                      "The condemned survives... for now...\n"
        break
      end
    end

    puts end_message
  end
end

class HumanPlayer
  attr_accessor :word_length, :revealed_word

  def set_word_length
    puts "Choose a dictionary word, and enter its length:"

    @word_length = gets.to_i
  end

  def guess
    letter = gets.chomp.downcase

    raise ArgumentError.new("Invalid. Try again.") if !(letter =~ /[a-z]/)

    letter
  end

  def check_guess(guess)
    puts "Please enter the places containing #{guess} (e.g. 0 3 4)"

    gets.split(' ').map(&:to_i)
  end

  def initialize_on_word(length, revealed)
    @word_length = length
    @revealed_word = revealed
  end
end

class ComputerPlayer
  attr_accessor :word_length, :revealed_word

  def initialize
    @possible_words = File.readlines('dictionary.txt').map!(&:chomp)
    @secret_word = choose_word
    @word_length = @secret_word.length
    @letters_guessed = []
    @revealed_word = nil
  end

  # this method intentionally left blank
  def set_word_length
  end

  def guess
    update_possible_words

    letter = letter_frequency.max_by { |_, v| v }.first
    @letters_guessed << letter
    letter
  end

  def check_guess(guess)
    idxs = []

    @secret_word.split('').each_index do |i|
      idxs << i if @secret_word[i] == guess
    end

    idxs
  end

  def initialize_on_word(length, revealed)
    @word_length = length
    @revealed_word = revealed
    @possible_words = initialize_on_length
  end

  private

  def choose_word
    @possible_words.sample
  end

  def initialize_on_length
    @possible_words.select { |word| word.length == word_length }
  end

  def update_possible_words
    @possible_words.select! { |word| match?(word) }
    @possible_words.reject! { |word| anti_match?(word) }
  end

  def match?(word)
    @revealed_word.each_index do |i|
      next if @revealed_word[i] == '_'
      return false unless @revealed_word[i] == word[i]
    end

    true
  end

  def anti_match?(word)
    @revealed_word.each_index do |i|
      if @revealed_word[i] == '_' && @letters_guessed.include?(word[i])
        return true
      end
    end

    false
  end

  def letter_frequency
    letters = Hash.new(0)

    @possible_words.each do |word|
      word.each_char do |c|
        letters[c] += 1 unless @letters_guessed.include?(c)
      end
    end

    letters
  end
end

if __FILE__ == $PROGRAM_NAME
  human = HumanPlayer.new
  computer = ComputerPlayer.new
  game = Game.new(computer, human)
  game.play
end

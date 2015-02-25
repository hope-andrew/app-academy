class Code
  def initialize(code = generate_secret_code)
    @secret_code = code
  end

  def generate_secret_code
    peg_options = %w(R G B Y O P)
    code = []

    4.times do
      code << peg_options[rand(6)]
    end

    code
  end

  def exact_matches(other_code)
    matches = 0
    4.times do |i|
      matches += 1 if other_code[i] == @secret_code[i]
    end

    matches
  end

  def near_matches(other_code)
    total_matches(other_code) - exact_matches(other_code)
  end


  def color_hash(code)
    hash = Hash.new(0)

    code.each do |color|
      hash[color] += 1
    end

    hash
  end

  private

  def total_matches(other_code)
    code_hash_player = color_hash(other_code)
    code_hash_comp = color_hash(@secret_code)
    matches = 0

    code_hash_player.each_key do |color|
      matches += [code_hash_player[color], code_hash_comp[color]].min
    end

    matches
  end
end

class Game
  MAX_GUESSES = 10

  def initialize
    @code = Code.new
  end

  def parse(input)
    guess = []

    input.each_char do |color|
      guess << color
    end

    raise ArgumentError.new 'Invalid Input Length' if guess.length != 4

    if guess.any?{|color| !%w(R G B Y O P).include?(color)}
      raise ArgumentError.new "Must provide valid colors (e.g RGBYOP)"
    end
    guess
  end

  def run
    end_message = "You lose..."

    MAX_GUESSES.times do

      begin
        puts "Please enter a guess (e.g. RGYB)"
        guess = parse(gets.chomp)
      rescue ArgumentError => e
        puts e
        retry
      end

      exact_matches = @code.exact_matches(guess)
      if exact_matches == 4
        end_message = "You win!!!"
        break
      end
      puts "Exact matches: #{exact_matches}"
      puts "Near matches: #{@code.near_matches(guess)}"
    end

    puts end_message
  end
end

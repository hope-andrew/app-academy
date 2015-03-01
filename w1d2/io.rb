def guessing_game
  secret_num = rand(100)
  guess = nil
  tracker = 0

  until guess == secret_num
    puts "Let's guess number:"
    guess = gets.chomp.to_i

    if guess > secret_num
      puts "too high"
    elsif guess < secret_num
      puts "too low"
    else
      puts "correct"
    end
    tracker += 1
  end
  puts tracker
end

# guessing_game


def shuffle_file

  print "Enter file:"
  filename = gets.chomp

  contents = File.readlines(filename).shuffle

  f = File.open("#{filename}-shuffled.txt", "w")
  f.puts contents
  f.close

end

shuffle_file

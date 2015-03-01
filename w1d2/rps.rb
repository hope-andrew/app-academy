def rps(choice)
  choices = %w(Rock Paper Scissors)
  comp_choice = choices[rand(3)]

  outcome = {'Rock' => 'Paper', 'Paper' => 'Scissors', 'Scissors' => 'Rock'}

  if choice == comp_choice
      "#{comp_choice}, Draw"
  elsif comp_choice == outcome[choice]
      "#{comp_choice}, Lose"
  else
      "#{comp_choice}, Win"
  end

end


puts rps('Rock')
puts rps('Paper')
puts rps('Scissors')

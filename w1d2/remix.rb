def remix (drinks)
  alcohols = drinks.map{|drink| drink[0]}
  mixers = drinks.map{|drink| drink[1]}
  remix_drinks = []

  alcohols.each do |alc|
    mixer_choice = mixers[rand(mixers.count)]
    remix_drinks << [alc, mixer_choice]
    mixers.delete(mixer_choice)
  end

  remix_drinks
end

p remix([["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]])

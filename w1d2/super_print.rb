def super_print(string, options = {})
  default = { times: 1, upcase: false, reverse: false}

  options = default.merge(options)

  string = string.upcase if options[:upcase]
  string = string.reverse if options[:reverse]

  options[:times].times { print string}
  puts
end

super_print("Hello")                                    #=> "Hello"
super_print("Hello", :times => 3)                       #=> "Hello" 3x
super_print("Hello", :upcase => true)                   #=> "HELLO"
super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"

options = {}
super_print("hello", options)

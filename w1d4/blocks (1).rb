class Array

  def my_each(&prc)
    self.length.times do |idx|
      prc.call(self[idx])
    end

    self
  end

  def my_map(&prc)
    mapped =[]

    self.my_each do |el|
      mapped << prc.call(el)
    end

    mapped
  end

  def my_select(&prc)
    selected = []

    self.my_each do |el|
      selected << el if prc.call(el)
    end

    selected
  end

  def my_inject(initial = nil, &prc)
    if initial.nil?
      index = 1
      injected = self.first
    else
      index = 0
      injected = initial
    end

    while index < self.length
      injected = prc.call(injected, self[index])
      index += 1
    end
    injected
  end

  def my_sort!(&prc)
    switches = true
    while switches# == true
      switches = false
      (0...self.length-1).each do |ind|
        val = prc.call(self[ind], self[ind+1])
        if val == 1
          self[ind], self[ind+1] = self[ind+1], self[ind]
          switches = true
        end
      end
    end
    self
  end
end

p [1, 2, 3].my_inject { |a, x| a + x }
#
# def eval_block(*args, &prc)
#   return puts "NO BLOCK GIVEN" if prc == nil
#    prc.call(*args)
# end

# eval_block("Kerry", "Washington", 23) do |fname, lname, score|
#   puts "#{lname}, #{fname} won #{score} votes."
# end
#
# eval_block(1,2,3,4,5) do |*args|
#   puts args.inject(:+)
# end
#
# eval_block(1,2,3 )

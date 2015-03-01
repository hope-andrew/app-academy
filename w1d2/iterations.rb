def factors(num)
  factors = []

  (1..num).each do |int|
    factors << int if num % int == 0
  end

  factors
end

def  bubble_sort(array)

  (0..array.length - 2).each do |idx1|
    (idx1..array.length - 1).each do |idx2|
      if array[idx1] > array[idx2]
        array[idx1],array[idx2] = array[idx2],array[idx1]
      end
    end
  end

  array
end

# p bubble_sort([1, 54, 7, 4, 7])

def substrings(string)
  substring_array = []

  (0..string.length - 1).each do |idx1|
    substring = ""
    (idx1..string.length - 1).each do |idx2|
      substring = string[idx1..idx2]
      substring_array << substring
    end
  end
  substring_array
end

# p substrings('cat')

def subwords (string)
  word_list = []
  
  File.foreach("dictionary.txt") do |line|
    word = line.chomp
    word_list << word if substrings(string).include?(word)
  end

  word_list
end

p subwords('cat')

#Problem 1: You have array of integers. Write a recursive solution to find
#the sum of the integers.
require 'byebug'
def sum_recur(array)
  sum = 0
  if array.length == 0
    sum = 0
  elsif array.length == 1
    sum = array[0]
  else
    sum = array.last + sum_recur(array[0...array.length-1])
  end

  sum

end

#Problem 2: You have array of integers. Write a recursive solution to
#determine whether or not the array contains a specific value.

def includes?(array, target)
  val = false
  if array.last == target
    val =  true
  else
    val = includes?(array[0...array.length-1],target) unless array.length==1
  end
   return val
end


#Problem 3: You have an unsorted array of integers. Write a recursive
#solution to count the number of occurrences of a specific value.

def num_occur(array, target)
  occ = 0
  if array.length == 1
    occ += 1 if array[0] == target
  else
    occ = num_occur(array[0...array.length-1], target)
    occ += 1 if array.last == target
  end
  occ
end


#Problem 4: You have array of integers. Write a recursive solution to
#determine whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  val = false
  if array[-1]+array[-2] == 12
    val = true
    return val
  else
    val = add_to_twelve?(array[0...array.length-1]) unless array.length == 1
  end
  val
end


#Problem 5: You have array of integers. Write a recursive solution to
#determine if the array is sorted.

def sorted?(array)
  val = true
  return true if array.length == 1 || array.length == 0
  if array[-2] > array[-1] == true
    val = false
    return false
  else
    val = sorted?(array[0...array.length-1]) unless array.length == 2
  end
  return val
end


#Problem 6: Write the code to give the value of a number after it is
#reversed. Must use recursion. (Don't use any #reverse methods!)

def reverse(number)
  num = number.to_s.chars

  if num.length == 1
    return num.join('').to_i
  else
    dig = num.pop
    # debugger
    new_num = reverse(num.join('').to_i)
    num = new_num.to_s.chars + dig.to_a
    num
  end
  num.join('').to_i
end

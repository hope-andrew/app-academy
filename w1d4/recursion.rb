def range(first, last)
  arr = [first]
  unless first == last
    arr += range(first + 1, last)
  end
  arr
end

def rec_sum(arr)
  sum = arr.pop
  unless arr.length == 0
    sum += rec_sum(arr)
  end
  sum
end

def expo(b,n)
  val = 1
  unless n == 0
    val = b * expo(b, n-1)
  end
  val
end


def expo2(b,n)
  val = 1
  unless n == 0
    if n.even?
      val = expo2(b, n/2) * expo2(b, n/2)
    else
      val = b * (expo2(b, (n-1)/2) * expo2(b, (n-1)/2))
    end
  end
  val
end

class Array

  def deep_dup
    new_arr = []
    self.each do |item|
      duplicated = item
      if item.is_a?(Array)
        new_arr += item.deep_dup
      end
       new_arr << duplicated
    end
    new_arr
  end

end

# a = [1, [2], [3, [4]]]
# b = a.deep_dup
# a[1] <<  5
# p a
# p b

def fibonacci(n)
  seq = [1,1]

  if n == 1
    seq[0]
  elsif n == 2
    seq[0..1]
  else
    counter = 0
    while counter <= n - 2
      seq << seq[counter] + seq[counter+1]
      counter += 1
    end
  end

  seq
end

def fibonacci2(n)

  if n == 0
    return []
  elsif n == 1
    return [1]
  elsif n == 2
    return [1, 1]
  else
    last = fibonacci(n-1)
    last << last[-1] + last[-2]
  end
end

def bsearch(array, target)
  half = array.length/2

  if array[half] == target
    array[half]
  elsif array.length == 0
    nil
  elsif array[half] < target
    bsearch(array[0...half], target)
  else
    bsearch(array[half..-1], target)
  end
end


def bsearch(arr, n )
  if arr[arr.length/2] == n
    pos = arr.length/2
  elsif arr.length <= 1
    nil
  else
    if n > arr[arr.length/2]
      new_arr = arr[arr.length/2...(arr.length)]
      return nil if bsearch(new_arr, n) == nil
      pos = bsearch(new_arr,n) + arr.length/2
    else n < arr[arr.length/2]
      new_arr = arr[0...arr.length/2]
      pos = bsearch(new_arr, n)
    end
  end
end

p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

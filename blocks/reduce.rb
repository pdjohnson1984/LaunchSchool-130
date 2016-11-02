def reduce(arr, starting_value = 0)
  counter = 0
  accumulator = starting_value

  while counter < arr.size
    accumulator = yield(accumulator, arr[counter])
    counter +=  1
  end

  accumulator
end


and
ads



array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass

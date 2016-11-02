def select(array)
  counter = 0
  new_array = []

  while counter < array.size
    num = yield(array[counter])
    if num
      new_array << array[counter]
    end
    counter += 1
  end

  new_array
end

array = [1, 2, 3, 4, 5]

select(array) { |num| num.odd? }
select(array) { |num| puts num }
select(array) { |num| num + 1 }

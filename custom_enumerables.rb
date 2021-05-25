# frozen_string_literal: true

module Enumerable
  def my_each
    counter = 0

    loop do
      break if counter == self.length

      yield self[counter]
      counter += 1
    end
    self
  end

  def my_each_with_index
    counter = 0

    loop do
      break if counter == self.length

      yield(self[counter], counter)
      counter += 1
    end
    self
  end

  def my_select
    array = []
    counter = 0

    loop do
      break if counter == self.length

      value = yield self[counter]
      array.push(self[counter]) if value == true
      counter += 1
    end
    array
  end

end

puts "my_each vs. each"
numbers = [1, 2, 3, 4, 5]
numbers.my_each { |item| puts item }
puts
numbers.each { |item| puts item }
puts

puts "my_each_with_index vs. each_with_index"
numbers = [1, 2, 3, 4, 5]
numbers.my_each_with_index { |item, index| puts "item: #{item} index: #{index}" }
puts
numbers.each_with_index { |item, index| puts "item: #{item} index: #{index}" }
puts

puts "my_select vs. select"
numbers = [1, 2, 3, 4, 5]
p numbers.my_select { |num| num.even? }
puts
p numbers.select { |num| num.even? }


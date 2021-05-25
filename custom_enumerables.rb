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

  def my_all?
    array = []
    counter = 0

    loop do
      break if counter == self.length

      value = yield self[counter]
      array.push(value)
      counter += 1
    end

    all_truthy_array = array.my_select { |val| val }
    all_truthy_array.length == self.length
  end

  def my_any?
    array = []
    counter = 0

    loop do
      break if counter == self.length

      value = yield self[counter]
      array.push(value)
      counter += 1
    end

    any_truthy_array = array.my_select { |val| val }
    any_truthy_array.length.positive?
  end

  def my_none?
    array = []
    counter = 0

    loop do
      break if counter == self.length

      value = yield self[counter]
      array.push(value)
      counter += 1
    end

    no_truthy_array = array.my_select { |val| val }
    no_truthy_array.length.zero?
  end

  def my_count(arg = nil, &my_block)
    if block_given?
      my_select(&my_block).length
    elsif arg.nil?
      self.length
    else
      truthy_array = self.my_select { |val| val == arg }
      truthy_array.length
    end
  end

  def my_map
    array = []
    counter = 0

    loop do
      break if counter == self.length

      array.push(yield self[counter])
      counter += 1
    end
    array
  end

  def my_inject(sum = 0)
    counter = 0

    loop do 
      break if counter == self.length

      sum = yield(sum, self[counter])
      counter += 1
    end
    sum
  end

  def multiply_els
    self.my_inject(1) { |sum, num| sum * num }
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

puts "my_all? vs all?"
numbers = [1, 2, 3, 4, 5]
p numbers.my_all? { |num| num > 0 }
puts
p numbers.all? { |num| num > 0 }
puts

puts "my_any? vs any?"
numbers = [1, 2, 3, 4, 5]
p numbers.my_any? { |num| num > 4 }
puts
p numbers.any? { |num| num > 4 }
puts

puts "my_none? vs none?"
numbers = [1, 2, 3, 4, 5]
p numbers.my_none? { |num| num < 1 }
puts
p numbers.none? { |num| num < 1 }
puts

puts "my_count vs count"
numbers = [1, 2, 3, 4, 5]
p numbers.my_count
puts
p numbers.count
puts
p numbers.my_count { |num| num - 1 == 0 }
puts
p numbers.count { |num| num - 1 == 0 }
puts
p numbers.my_count(2)
puts
p numbers.count(2)

puts "my_map vs map"
numbers = [1, 2, 3, 4, 5]
p numbers.my_map { |num| num + 1 }
puts
p numbers.map { |num| num + 1 }
puts

puts "my_inject vs inject"
numbers = [1, 2, 3, 4, 5]
p numbers.my_inject { |sum, num| sum + num }
puts
p numbers.inject { |sum, num| sum + num }
puts
p numbers.my_inject(100) { |sum, num| sum + num }
puts
p numbers.inject(100) { |sum, num| sum + num }
puts

puts "mulitply_els"
numbers = [2, 4, 5]
p numbers.multiply_els

puts "my_map with proc"
numbers = [1, 2, 3, 4, 5]
double = Proc.new { |n| n * 2 }
p numbers.my_map(&double)
puts
p numbers.map(&double)

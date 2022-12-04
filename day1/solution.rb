#!/usr/bin/ruby

def find_most_calories
    max_calories = 0
    current_calories = 0
    File.foreach("input") do |line|
        if line.strip.empty?
            max_calories = current_calories if current_calories > max_calories
            current_calories = 0
            next
        end
        current_calories += line.to_i
    end
    max_calories
end

def find_sum_of_top_three_most_calories
    calorie_list = []
    current_calories = 0
    File.foreach("input") do |line|
        if line.strip.empty?
            calorie_list << current_calories
            current_calories = 0
            next
        end
        current_calories += line.to_i
    end
    calorie_list.sort[-3..-1].sum
end

puts "Part 1 answer: #{find_most_calories}"
puts "Part 2 answer: #{find_sum_of_top_three_most_calories}"
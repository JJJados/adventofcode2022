#!/usr/bin/ruby

def common_char(a)
    raise StandardError.new("Array must be of size 3") if a.length != 3
    (a[0].chars & a[1].chars) & a[2].chars
end

def char_value(c)
    return c.ord - 96 if c == c.downcase
    return c.ord - 38 if c == c.upcase
end

def rucksack_priorities_sum
    total = 0
    File.foreach("input") do |line|
        halfway = (line.strip.length/2).ceil
        first_rucksack = line[0..halfway-1]
        second_rucksack = line[halfway..-1]
        (first_rucksack.chars & second_rucksack.chars).each do |c| 
            total += char_value(c)
        end
    end
    total
end

def rucksack_group_priorties_sum
    total = 0
    group_one = []
    group_two = []
    File.foreach("input") do |line|
        group_two << line.strip if group_two.length < 3 && group_one.length == 3
        group_one << line.strip if group_one.length < 3
        if group_one.length == 3 && group_two.length == 3
            common_char(group_one).each { |c| total += char_value(c) }
            common_char(group_two).each { |c| total += char_value(c) }
            group_one = []
            group_two = []
        end
    end
    total
end

puts "Part 1 answer: #{rucksack_priorities_sum}"
puts "Part 2 answer: #{rucksack_group_priorties_sum}"
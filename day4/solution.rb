#!/usr/bin/ruby

def get_pair_bounds(pair)
    lower_bound, upper_bound = pair.split("-")
    [lower_bound.to_i, upper_bound.to_i]
end

def fully_contained_pairs?(first_pair, second_pair)
    lower_bound_first_pair, upper_bound_first_pair = get_pair_bounds(first_pair)
    lower_bound_second_pair, upper_bound_second_pair = get_pair_bounds(second_pair)
    return true if lower_bound_first_pair <= lower_bound_second_pair && upper_bound_second_pair <= upper_bound_first_pair
    return true if lower_bound_second_pair <= lower_bound_first_pair && upper_bound_first_pair <= upper_bound_second_pair
    false
end

def overlapping_pairs?(first_pair, second_pair)
    lower_bound_first_pair, upper_bound_first_pair = get_pair_bounds(first_pair)
    lower_bound_second_pair, upper_bound_second_pair = get_pair_bounds(second_pair)
    ((lower_bound_first_pair..upper_bound_first_pair).to_a & (lower_bound_second_pair..upper_bound_second_pair).to_a).any?
end

def total_fully_contained_pairs
    total = 0
    File.foreach("input") do |line|
        first_pair, second_pair = line.split(",")
        total += 1 if fully_contained_pairs?(first_pair, second_pair)
    end
    total
end

def total_overlapping_pairs
    total = 0
    File.foreach("input") do |line|
        first_pair, second_pair = line.split(",")
        total += 1 if overlapping_pairs?(first_pair, second_pair)
    end
    total
end

puts "Part 1 answer: #{total_fully_contained_pairs}"
puts "Part 2 answer: #{total_overlapping_pairs}"


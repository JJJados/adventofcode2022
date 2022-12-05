#!/usr/bin/ruby

GAME_MAPPING = {
    "A X" => 4,
    "A Y" => 8,
    "A Z" => 3,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 7,
    "C Y" => 2,
    "C Z" => 6
}

GAME_MAPPING_2 = {
    "A X" => 3,
    "A Y" => 4,
    "A Z" => 8,
    "B X" => 1,
    "B Y" => 5,
    "B Z" => 9,
    "C X" => 2,
    "C Y" => 6,
    "C Z" => 7
}

def rock_paper_scissors_total_score(game_mapping)
    total_score = 0
    File.foreach("input") do |line|
        total_score += game_mapping[line.strip]
    end
    total_score
end

puts "Part 1 answer: #{rock_paper_scissors_total_score(GAME_MAPPING)}"
puts "Part 2 answer: #{rock_paper_scissors_total_score(GAME_MAPPING_2)}"


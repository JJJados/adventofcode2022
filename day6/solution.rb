#!/usr/bin/ruby

def start_of_packet_marker(num_distinct_char: 4)
    marker = 0
    packet = []
    line = File.open("input", &:readline)
    line.chars.each do |c|
        marker += 1
        packet << c if packet.length < num_distinct_char
        if packet.length == num_distinct_char
            break if packet.uniq.length == packet.length
            packet.shift
        end
    end
    marker
end

puts "Part 1 solution: #{start_of_packet_marker}"
puts "Part 2 solution: #{start_of_packet_marker(num_distinct_char: 14)}"

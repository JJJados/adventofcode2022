#!/usr/bin/ruby

def create_crate_map(crate_mappings, line)
    line = line.chars.each_slice(4).map(&:join)
    if crate_mappings.empty?
        return line.each_with_index.map do |crate, i|
            temp = crate.strip.delete!("[]")
            temp.nil? ? [i+1, []] : [i+1, [temp]]
        end.to_h
    end

    line.each_with_index.map do |crate, i| 
        temp = crate.strip.delete!("[]")
        crate_mappings[i+1].prepend(temp) unless temp.nil?
    end
    crate_mappings
end

def top_crates_after_rearrange(multiple_crates: false)
    crate_mappings = {}
    crate_mappings_ready = false
    File.foreach("input") do |line|
        if line.strip.empty?
            crate_mappings_ready = true
            next
        end
        unless crate_mappings_ready
            crate_mappings = create_crate_map(crate_mappings, line) 
            next
        end
        n, s, e = line.split(" ").values_at(1, 3, 5).map(&:to_i)
        n.times { crate_mappings[e] << crate_mappings[s].pop unless crate_mappings[s].empty? } unless multiple_crates
        crate_mappings[e] += crate_mappings[s].pop(n) unless crate_mappings[s].empty? || !multiple_crates
    end
    crate_mappings.values.map { |crates| crates[-1] }.join
end

puts "Part 1 solution: #{top_crates_after_rearrange}"
puts "Part 2 solution: #{top_crates_after_rearrange(multiple_crates: true)}"

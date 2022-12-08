#!/usr/bin/ruby

def calculate_folder_sizes
    current_path = ""
    folder_sizes = {}
    File.readlines("input", chomp: true).map(&:split).each do |line|
        case line
            in  ["$", "cd", ".."]
                path = "#{current_path.split("/")[0..-2].join("/")}/"
                current_path = path.empty? ? "/" : path
            in ["$", "cd", dir]
                parent_dir = current_path
                current_path = dir == "/" ? dir : current_path + "#{dir}/"
                folder_sizes[current_path] = { parent_dir: parent_dir, size: 0} unless folder_sizes.has_key?(current_path)
            in [size, file]
                folder_sizes[current_path][:size] += size.to_i
            else
        end
    end
    folder_sizes.values.reverse_each { |folder| folder_sizes[folder[:parent_dir]][:size] += folder[:size] if folder[:parent_dir] != "" }
    folder_sizes
end

def calculate_size_folders(max_size: 100_000)
    total_size = 0
    folder_sizes = calculate_folder_sizes
    folder_sizes.values.each { |folder| total_size += folder[:size] if folder[:size] <= max_size }
    total_size
end

def free_up_just_enough_space(max_storage: 70_000_000, needed_storage: 30_000_000)
    sizes = []
    folder_sizes = calculate_folder_sizes
    size_to_delete = needed_storage - (max_storage - folder_sizes["/"][:size])
    folder_sizes.values.each { |folder| sizes << folder[:size] if size_to_delete <= folder[:size] }
    sizes.sort[0]
end

puts "Part 1 solution: #{calculate_size_folders}"
puts "Part 2 solution: #{free_up_just_enough_space}"

#!/usr/bin/ruby

def is_exterior(row, col, max_row, max_col)
    row == 0 || row+1 == max_row || col == 0 || col+1 == max_col
end

def check_right(trees, current_tree, row, s, e)
    (s+1..e).each do |n|
        trees[row][s][:right] = trees[row][s][:right] + 1
        return false if current_tree[:value] <= trees[row][n][:value]
    end
    true
end

def check_left(trees, current_tree, row, s, e)
    (e-1).downto(s).to_a.each do |n|
        trees[row][e][:left] = trees[row][e][:left] + 1
        return false if current_tree[:value] <= trees[row][n][:value]
    end
    true
end

def check_up(trees, current_tree, col, s, e)
    (e-1).downto(s).to_a.each do |n|
        trees[e][col][:up] = trees[e][col][:up] + 1
        return false if current_tree[:value] <= trees[n][col][:value]
    end
    true
end

def check_down(trees, current_tree, col, s, e)
    (s+1..e).each do |n|
        trees[s][col][:down] = trees[s][col][:down] + 1
        return false if current_tree[:value] <= trees[n][col][:value]
    end
    true
end

def num_visible_trees
    trees = []
    lines = File.readlines("input", chomp: true)
    lines.each_with_index do |line, i| 
        trees << line.split("").each_with_index.map do |l, j|
            is_exterior(i, j, lines.length, line.length) ? { value: l.to_i, visible: true, down: 0, up: 0, left: 0, right: 0 } 
                : { value: l.to_i, visible: false, down: 0, up: 0, left: 0, right: 0 }
        end
    end

    total_visible = 0
    highest_scenic_score = 0
    return 0 if trees.empty?

    max_col = trees.length - 1
    max_row = trees[0].length - 1
    trees.each_with_index do |row, i|
        row.each_with_index do |tree, j|
            if check_right(trees, tree, i, j, max_row)
                trees[i][j][:visible] = true
            end
            if check_left(trees, tree, i, 0, j)
                trees[i][j][:visible] = true
            end
            if check_up(trees, tree, j, 0, i)
                trees[i][j][:visible] = true
            end
            if check_down(trees, tree, j, i, max_col)
                trees[i][j][:visible] = true
            end
        end
    end
    trees.each do |row|
        row.each do |tree| 
            total_visible += 1 if tree[:visible]
            scenic_score = tree[:up] * tree[:down] * tree[:left] * tree[:right]
            highest_scenic_score = scenic_score if highest_scenic_score < scenic_score
        end
    end 
    [total_visible, highest_scenic_score]
end

total_visible, highest_scenic_score = num_visible_trees
puts "Part 1 answer: #{total_visible}"
puts "Part 2 answer: #{highest_scenic_score}" 

def count_moves(count)
  return 1 if count == 1

  2 * count_moves(count - 1) + 1
end

def test(n)
  puts "number of moves with #{n} rings is #{count_moves(n)}"
end

1.upto(10) { |n| test(n) }

test(100)
test(1000)
test(10000)
#test(100000)

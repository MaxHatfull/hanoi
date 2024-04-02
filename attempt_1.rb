# TODO: Fix the problem of going back and forth between the same stick over and over

MOVE_CACHE = {}

def countMoves(state, count = 0)
  MOVE_CACHE[state] = count
  return count if state[0].empty? && state[1].empty?

  possibleNextStates(state).map do |move|
    countMoves(move, count + 1) if !MOVE_CACHE.key?(move) || MOVE_CACHE[move] > count + 1
  end.compact.min || Float::INFINITY
end

def possibleNextStates(state)
  state.flat_map.with_index do |_, index|
    [
      makeMove(state, index, 0),
      makeMove(state, index, 1),
      makeMove(state, index, 2)
    ].compact
  end.select { |move| legalState?(move) }
end

def makeMove(state, from, to)
  return nil if from == to || state[from].empty?

  new_state = state.dup.map(&:dup)

  ring = new_state[from].pop
  new_state[to].push(ring)
  new_state
end

def legalState?(state)
  state.all? { |stick| stick.sort.reverse == stick }
end

def test(n)
  state = [n.downto(1).to_a,[],[]]
  puts "number of moves with #{n} rings is #{countMoves(state)}"
end

1.upto(10) { |n| test(n) }


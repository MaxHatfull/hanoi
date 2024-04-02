MOVE_CACHE = {}

def count_moves(state, count = 0)
  MOVE_CACHE[state] = count
  return count if state[0].empty? && state[1].empty?

  possible_next_states(state).map do |move|
    count_moves(move, count + 1) if should_visit_state?(count, move)
  end.compact.min || Float::INFINITY
end

def should_visit_state?(count, move)
  !MOVE_CACHE.key?(move) || MOVE_CACHE[move] > count + 1
end

def possible_next_states(state)
  state.flat_map.with_index do |_, index|
    [
      make_move(state, index, 0),
      make_move(state, index, 1),
      make_move(state, index, 2)
    ].compact
  end.select { |move| legal_state?(move) }
end

def make_move(state, from, to)
  return nil if from == to || state[from].empty?

  new_state = state.dup.map(&:dup)

  ring = new_state[from].pop
  new_state[to].push(ring)
  new_state
end

def legal_state?(state)
  state.all? { |stick| stick.sort.reverse == stick }
end

def test(n)
  state = [n.downto(1).to_a,[],[]]
  puts "number of moves with #{n} rings is #{count_moves(state)}"
end

1.upto(10) { |n| test(n) }


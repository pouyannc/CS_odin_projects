# Return the fibonacci sequence up to the nth term. First using iteration, then recursion.

def fibs(n)
  sequence = []
  n.times do |i|
    if i == 0
      sequence.push(0)
    elsif i == 1
      sequence.push(1)
    else
      sequence.push(sequence[i-1] + sequence[i-2])
    end
  end
  sequence
end

def fibs_rec(n, sequence = [])
  return sequence.push(0) if n == 1
  sequence = fibs_rec(n-1, sequence).push(1) if n == 2
  sequence = fibs_rec(n-1, sequence).push(sequence[-1] + sequence[-2]) if n > 2
  return sequence
end

p fibs(8)
p fibs_rec(8)
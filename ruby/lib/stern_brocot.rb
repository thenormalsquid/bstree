class SternBrocot
  MAX = 2 ** (1.size * 8 - 2) - 1

  def self.rationalize number
    return [0, 1] if number.to_f == 0.0

    # q is a particular node with a rational number
    # expressed in the form n/d.
    q = number

    a = 0
    b = 1
    c = 1
    d = 0 # 1/MAX

    # loop here
    l = a/b
    # h = c/d
    h = d.zero? ?  MAX : c/d
    mn = a + b
    md = c + d
    m = mn / md.to_f

    # first, ensure we're getting 1/1 back.
    # return [mn.to_i, md.to_i] if m == q

    iteration = 1

    # binding.pry if q.zero?

    while true
      # before trying to iterate (or recurse), let's do q < 1, then q > 1

      return [mn.to_i, md.to_i] if m == q

      # binding.pry

      if m < q # on the first iteration, this means the q >= 1
        a = mn
        b = md
        l = m
        # binding.pry
      else
        c = mn
        d = md
        h = m
      end

      mn = a + b
      md = c + d
      m = mn / md.to_f

      return [mn.to_i, md.to_i] if m == q

      iteration += 1
      puts md.to_i if md.to_i.modulo(5_000_000).zero?
      break if iteration > 2001 # MAX - 1

    end

    return [mn.to_i, md.to_i]

    # also, return if past a certain threshold in precision
    # return [a+b, c+d] if Math.abs(q - number) < 0.0005
    # increment a, b, c, d
    # end loop here

=begin
    Initialize two values L and H to 0/1 and 1/0, respectively.
      Until q is found, repeat the following steps:
      Let L = a/b and H = c/d; compute the mediant M = (a + c)/(b + d).
      If M is less than q, then q is in the open interval (M,H); replace L by M and continue.
      If M is greater than q, then q is in the open interval (L,M); replace H by M and continue.
      In the remaining case, q = M; terminate the search algorithm.
=end
  end
end

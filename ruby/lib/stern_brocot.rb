class SternBrocot
  MAX = 2 ** (1.size * 8 - 2) - 1
  TOL = 0.001

  def self.rationalize number
    return [0, 1] if number.to_f == 0.0

    q = number

    a = 0
    b = 1
    c = 1
    d = 0

    l = a/b
    h = d.zero? ? MAX : c/d
    mn = a + b
    md = c + d
    m = mn / md.to_f

    iteration = 1 # ejection handle

    while true
      return [mn.to_i, md.to_i] if m == q

      # binding.pry

      if m < q
        a = mn
        b = md
        # l = m
      else # m > q
        c = mn
        d = md
        # h = m
      end

      mn = a + b
      md = c + d
      m = mn / md.to_f

      # return [mn.to_i, md.to_i] if m == q
      return [mn.to_i, md.to_i] if (m - q).abs < TOL

      iteration += 1
      # puts md.to_i if md.to_i.modulo(10).zero?
      break if iteration > 15

    end

    # also, return if past a certain threshold in precision
    # return [a+b, c+d] if Math.abs(q - number) < 0.0005
    [mn.to_i, md.to_i]

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

class SternBrocot
  MAX = 2 ** (1.size * 8 - 2) - 1

  def self.rationalize number
    # q is a particular node with a rational number
    # expressed in the form n/d.
    q = 0

    a = 0
    b = 1
    c = 1
    d = MAX

    # loop here
    l = a/b
    h = c/d
    m = (a+b)/(c+ d)

    return [a+b, c+d] if q == m

    if m < q
      l = m
    else
      h = m
    end
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

class Money
  include Comparable

  def initialize money
    @money = money.to_s
  end

  #
  # TODO: spec me
  #
  def source
    @money.
      gsub(/[^0-9\+\-\.\*]+/, '').  # only digits, dots, pluses, multiple sign and minuses allowed
      gsub(/\+{2,}/, '+').        # replaces '+++' with '+'
      gsub(/\-{2,}/, '-').        # replaces '---' with '-'
      gsub(/\.{2,}/, '.').        # replaces '...' with '.'
      gsub(/\*{2,}/, '*')         # replaces '***' with '*'
  end

  def to_f
    (eval source).to_f.round(2)
  end

  def <=> another
    to_f <=> another.to_f
  end
end

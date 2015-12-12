class Formula
  class << self
    def calculate string
      string = string.to_s.
        gsub(/[^0-9\+\-\.\*]+/, ''). # only digits, dots, pluses, multiple sign and minuses allowed
        gsub(/\+{2,}/, '+').         # replaces '+++' with '+'
        gsub(/\-{2,}/, '-').         # replaces '---' with '-'
        gsub(/\*{2,}/, '*').         # replaces '***' with '*'
        gsub(/\.{2,}/, '.').         # replaces '...' with '.'
        gsub(/[\+\-\*\.]{1,}$/, '')  # remove pluses, minuses, dots and multiple signs at end of string

      BigDecimal.new(eval(string).to_s)
    end
  end
end

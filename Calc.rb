class Calc
  DIGITS = %w(zero one two three four five six seven eight nine)
  OPERATORS = %w(plus minus times divided_by)
  
  attr_accessor :first, :second, :operator  
  
  DIGITS.each_with_index do |digit, numeric_value|
    define_method(digit) do
      if @operator == nil
        @first = numeric_value
        self
      else
        @second = numeric_value
        calculate
      end
    end
  end
 
  OPERATORS.each do |operator|
    define_method(operator) do
      @operator = operator.to_sym
      self
    end
  end
 
  def calculate    
    case operator
    when :plus
      first + second
    when :minus
      first - second
    when :times
      first * second
    when :divided_by
      first / second
    end    
  end
end
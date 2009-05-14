module SNMP
  class OctetString
    def to_mac
      result_digits = []
      self.each_byte do |byte|
        digit1 = 0
        digit2 = 0
        (0..7).to_a.reverse.each do |i|
        	if byte >= 2**i
        	  (i > 3) ? digit1 += 2**(i-4) : digit2 += 2**i
        	  byte -= 2**i
        	end
      	end
      	[digit1, digit2].each_with_index do |digit, index|
      	  case digit
      	    when 15
      	      (index == 0) ? digit1 = "F" : digit2 = "F"
      	    when 14
      	      (index == 0) ? digit1 = "E" : digit2 = "E"
      	    when 13
              (index == 0) ? digit1 = "D" : digit2 = "D"
      	    when 12
              (index == 0) ? digit1 = "C" : digit2 = "C"
      	    when 11
              (index == 0) ? digit1 = "B" : digit2 = "B"
      	    when 10
              (index == 0) ? digit1 = "A" : digit2 = "A"
    	    end
    	  end
      	result_digits << "#{digit1}#{digit2}"
      end
      result_digits.join(':')
    end
  end
end
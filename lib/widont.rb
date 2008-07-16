module Widont
  class << self
    def widont_single(text)
  		text.strip!
  		text[text.rindex(' '), 1] = '&nbsp;' if text.rindex(' ') and !text.include?('&nbsp;')
  		text
  	end
  	alias_method :widont, :widont_single
	end
end
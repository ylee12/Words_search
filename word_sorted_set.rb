require 'set'

class WordSortedSet < SortedSet

	#override the <=> operator to compare length of the word
	def <=>(other_word)
     self.length <=> other_word.length
    end
end
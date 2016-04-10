#require_relative "word_sorted_set"
require 'logger'


class ConcatWOrd

	attr_accessor :file_name

	def initialize(file_name)

		@file_name = file_name
		#@words_set = WordSortedSet.new()
		@hash_by_word_length = {}
		@hash_by_alphabet = {}
		@word_found_array = []

		#set up the logger


        @my_logger = Logger.new(STDOUT)
        @my_logger.level = Logger::DEBUG

        @my_rslogger = Logger.new('result.txt')
        @my_rslogger.level = Logger::INFO




	end


	def start_process()

		#read in the file and set up the structure
		File.open(@file_name, "r") do |f|
        	
        	while line = f.gets
        	  

        	  #@my_logger.debug line

        	  #split the words(with space separated) in a line into array of words, then 
        	  aw = line.split(/\s/)
        	  #@my_logger.debug "aw is #{aw}."

        	  aw.each do |i|  

        	  	# for 
        	  	#@my_logger.debug "In AW block, i is #{i}"

        	  	first_letter  = i[0]
        	  	word_length = i.length

        	  	
        	  	#set up the hash word dictionary for quick look up

        	  	#check if the key exist in the hash
        	  	if @hash_by_word_length.has_key?(word_length)

        	  		array_word = @hash_by_word_length[word_length]

        	  		#add the word into the corresponding hash structure
        	  		array_word << i
        	  		@hash_by_word_length[word_length] = array_word

        	  	else

        	  		# create the word aray and add the word to the array associated with the key
        	  		array_word = Array.new()
        	  		array_word << i
        	  		@hash_by_word_length[word_length] = array_word

        	  	end



        	  	if @hash_by_alphabet.has_key?(first_letter)

        	  		array_word_2 = @hash_by_alphabet[first_letter]

        	  		#add the word into the corresponding hash structure
        	  		array_word_2 << i
        	  		@hash_by_alphabet[first_letter] = array_word_2


        	  	else

        	  		# create the word aray and add the word to the array associated with the key
        	  		array_word_2 = Array.new()
        	  		array_word_2 << i
        	  		@hash_by_alphabet[first_letter] = array_word_2

        	  	end




        	  	#@words_set << i


        	  end


        	end

        	#print out the set
        	#cnt = 0
        	#@words_set.each do |i| 
        	#	@my_logger.debug "word #{cnt} in sets is #{i}"
        	#	cnt += 1
        	#end


            #for debug print...
        	##@hash_by_alphabet.each do |key, value| 
##
        	##	@my_logger.debug "Array in Alphabet hash. key = #{key}. Value = #{value}"
##
        	##end
##
        	##@my_logger.debug "================================================"
##
        	##@hash_by_word_length.each do |key, value| 
##
        	##	@my_logger.debug "Array in word length hash. key = #{key}. Value = #{value}"
##
        	##end


        end

        find_answers()

	end

	def find_answers

		

		#get the keys in reverse order
        keys_in_hash_word_length_array = @hash_by_word_length.keys.sort { |a, b|  b <=> a }
        @my_logger.debug "keys_in_hash_word_length_array is #{keys_in_hash_word_length_array}."

		#find the concat words
		#loop through the array
		keys_in_hash_word_length_array.each do |i|

			@my_logger.debug "================================================"

			@my_logger.debug "Word length is #{i}"
			words = @hash_by_word_length[i]
			#word_start_match_index = 0

			#find the match
			words.each do | word|

				word_length = word.length
				word_found = false
				word_start_match_index = 0
				sub_str = word.slice(word_start_match_index, word_length)

				break if sub_str.length == 1

                
				@my_logger.debug "Working on word #{word}."
				#@my_logger.debug "Working on sub_str #{sub_str}."

				while word_start_match_index < word_length and !word_found

				  #find the first letter of the word
				  first_let = sub_str[0]

				  @my_logger.debug ("Sub_str is #{sub_str}")
				  @my_logger.debug "first_let is #{first_let}"
  
                  # get the compare words from the hash array
				  compare_words = @hash_by_alphabet[first_let]

				  break if compare_words == nil
				  break if sub_str.length == 1



				  #@my_logger.debug "Before sort, compare_words is #{compare_words}"

				  #compare_words.sort_by! { |i| i.length}

				  #sort in alphabetical order and length in reverse order
				  compare_words.sort! { |x, y| x <=> y && y.length <=> x.length}
				  #compare_words.sort! { |x, y| x <=> y }
				  @my_logger.debug "After sort, compare_words is #{compare_words}"



  
				  
				  sub_word_found = false
				  compare_words.each do |i|

				  	#@my_logger.debug "===================================================="
  
				  	@my_logger.debug "Word is #{word}. Comparing sub_str #{sub_str} with subword #{i}. word_start_match_index is #{word_start_match_index}"
				  	

				  	found_index = nil

				  	found_index = sub_str.index(/\A#{i}/) if word != i and sub_str.length >= i.length and sub_str[1] >= i[1]
  
				  	if found_index != nil
  
				  		# found a match
				  		@my_logger.debug "found a match: Word is #{word}. Sub_str is #{sub_str}. subword is #{i}. word_start_match_index is #{word_start_match_index}."

				  		sub_word_length = i.length

				  		#move the word pointer to the next starting location
				  		word_start_match_index += sub_word_length

				  		sub_word_found = true

				  		@my_logger.debug "Here! word_start_match_index is #{word_start_match_index}. word_length is #{word_length}."

				  		#see if we found the entire match and make sure word not comparing to itself
				  		if word_start_match_index >= word_length and word != sub_str
				  			word_found = true
				  		end

				  		#get the next sub_str to match
				  		sub_str = word.slice(word_start_match_index, word_length - word_start_match_index) if !word_found 
  
				  		break;
  
				  	end
  
				  end

				  if sub_word_found == false

                    # exaust the entire aphabet words array and not match
				  	break;


				  end



				end

				if word_found == true

					@word_found_array << word

					@my_rslogger.info "\nResult now is #{@word_found_array} "

					@my_logger.debug "*********************************"

					@my_logger.debug "Yeeh! Found a matching word #{word}."
				end


			end

		end

		@my_logger.debug "Done!"

	
	end


	def print_result

		@my_logger.info "\n\n"

		if @word_found_array.length >= 2

		    @my_logger.info "The longest concatenated word is #{@word_found_array[0]}."
		    @my_logger.info "The 2nd longest concatenated word is #{@word_found_array[1]}."
		    @my_logger.info "The total count of concatenated word is #{@word_found_array.length}."

		else
			@my_logger.info "Sorry. I can not find the matching words for your answer."
		end
		
	end


end


cw = ConcatWOrd.new(ARGV[0])
cw.start_process
cw.print_result
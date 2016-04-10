
This program reads the file and do the following:

1. Find the longest concatenated word (that is, the longest word that is comprised entirely of
shorter words in the file)
2. Find the 2nd longest concatenated word
3. Find the total count of all the concatenated words in the file

For example, if the file contained:
cat
cats
catsdogcats
dog
dogcatsdog
hippopotamuses
rat
ratcatdogcat
the longest concatenated word would be 'ratcatdogcat' with 12 characters. ‘hippopotamuses’ is
a longer word, however it is not comprised entirely of shorter words in the list. The 2nd longest
concatenated word is ‘catsdogcats’ with 11 characters. The total number of concatenated words
is 3. Note that ‘cats’ is not a concatenated word because there is no word ‘s’ in the list.


To run this application, please have Ruby installed in your system. Then type the following in the same directory of where you placed the concat_word.rb file.

ruby concat_word.rb test_data.txt. For example,
[ylee@ylee-asus word_search]$ ruby concat_word.rb long_data.txt
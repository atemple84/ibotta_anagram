module WordsHelper
  def self.findAnagrams(words, word, limit=nil)
    anagram = {'anagrams' => []}
    
    # Sanity check
    if words.nil?
      return anagram
    end

    # We'll compare via sorted hash table.
    # First create main hash table to compare against
    wordHash = makeHashTable(word)
    
    # Go through word list. Already know they are all of same size
    words.each do |wordcompare|
      # skip over identical word
      if (wordcompare.word == word)
        next
      end
      
      # Build hash for comparable word, then match
      wordcompareHash = makeHashTable(wordcompare.word)
      if (wordcompareHash == wordHash)
        anagram['anagrams'] << wordcompare.word

        # Break once on limit
        unless limit.nil?
          limit -= 1
          if limit < 1
            break
          end
        end
      end
    end
    
    anagram
  end
  
  # Build hashtable by character and number of times character is in word
  def self.makeHashTable(word)
    hashtable = {}
    word.downcase.each_char do |c|
      if (hashtable.key?(c))
        hashtable[c] += 1
      else
        hashtable[c] = 0
      end
    end
    
    hashtable
  end
end

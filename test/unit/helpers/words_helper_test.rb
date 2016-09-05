require 'test_helper'

class WordsHelperTest < ActionView::TestCase
  
  def setup
    @words = []
    @words << Word.new(:word => "read") << Word.new(:word => "dear") << Word.new(:word => "dare")
  end
  
  def teardown
    @words = nil
  end
  
  def test_make_hashtable
    # use myString
    testhash = {"m" => 0, "y" => 0, "s" => 0, "t" => 0, "r" => 0, "i" => 0, "n" => 0, "g" => 0}
    actualhash = WordsHelper.makeHashTable("myString")

    assert_not_nil(actualhash)
    assert_equal(actualhash,testhash)
  end

  def test_find_anagrams
    # use "read" as test word for finding anagram
    testanagrams = {"anagrams" => ["dear","dare"]}
    actualanagrams = WordsHelper.findAnagrams(@words,"read")

    assert_not_nil(actualanagrams)
    assert_equal(actualanagrams,testanagrams)
    
    # Test using a limit
    testanagrams = {"anagrams" => ["dear"]}
    actualanagrams = WordsHelper.findAnagrams(@words,"read",1)

    assert_not_nil(actualanagrams)
    assert_equal(actualanagrams,testanagrams)
  end
end

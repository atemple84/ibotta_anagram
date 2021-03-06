require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: "read", format: 'json'
    assert_response :success
    assert_equal(200, @response.status)
    
    # Parse to json and compare
    responsejson = JSON.parse(@response.body)
    assert_not_nil(responsejson)
    assert_equal(responsejson["word"], "read")
    assert_equal(responsejson["wordsize"], 4)
  end
  
  test "should get anagrams" do
    # Find anagrams for "read"
    get :anagram, id: "read", format: "json"
    assert_response :success
    assert_equal(200, @response.status)
    
    responsejson = JSON.parse(@response.body)
    assert_not_nil(responsejson)
    assert_not_nil(responsejson['anagrams'])
    expected_anagrams = %w(dare dear)
    assert_equal(responsejson['anagrams'].sort, expected_anagrams)
  end

  test "should get anagrams with limit" do
    # Find anagrams for "read" with limit of 1
    get :anagram, id: "read", format: "json", limit: 1
    assert_response :success
    assert_equal(200, @response.status)
    
    responsejson = JSON.parse(@response.body)
    assert_not_nil(responsejson)
    assert_not_nil(responsejson['anagrams'])
    assert_equal(responsejson['anagrams'].size, 1)
  end

  test "should get anagrams without match" do
    # Make sure no anagrams found
    get :anagram, id: "zyxwv", format: "json"
    assert_response :success
    assert_equal(200, @response.status)
    
    responsejson = JSON.parse(@response.body)
    assert_not_nil(responsejson)
    assert_not_nil(responsejson['anagrams'])
    assert_equal(responsejson['anagrams'].size, 0)
  end
  
  test "should create words" do
    post :create, words: ["myString", "stringMy", "ingStrYm"], format: "json"
    assert_response :success
    assert_equal(201, @response.status)
    
    # Retrieve the added items as anagrams
    get :anagram, id: "mystring", format: "json"
    assert_response :success
    assert_equal(200, @response.status)
    
    responsejson = JSON.parse(@response.body)
    expected_anagrams = %w(ingstrym stringmy)
    assert_equal(responsejson['anagrams'].sort, expected_anagrams)
  end
  
  test "should delete all words" do
    delete :destroy_all, format: 'json'
    assert_response :success
    assert_equal(204, @response.status)
    
    # Make sure no more anagrams are returned
    get :anagram, id: "read", format: "json"
    assert_response :success
    assert_equal(200, @response.status)

    responsejson = JSON.parse(@response.body)
    assert_empty(responsejson['anagrams'])
  end

  test "should delete all words multiple" do
    3.times do
      delete :destroy_all, format: 'json'
      assert_response :success
      assert_equal(204, @response.status)
    end
    
    # Make sure no more anagrams are returned
    get :anagram, id: "read", limit: 1, format: "json"
    assert_response :success
    assert_equal(200, @response.status)

    responsejson = JSON.parse(@response.body)
    assert_empty(responsejson['anagrams'])
  end

  test "should delete single word" do
    delete :destroy, id: "dear", format: 'json'
    assert_response :success
    assert_equal(200, @response.status)
    
    # At least 1 anagram should be returned
    get :anagram, id: "read", limit: 1, format: "json"
    assert_response :success
    assert_equal(200, @response.status)

    responsejson = JSON.parse(@response.body)
    assert_equal(responsejson['anagrams'],["dare"])
  end
  
  test "should get word count" do
    get :count, format: 'json'
    assert_response :success
    assert_equal(200, @response.status)

    responsejson = JSON.parse(@response.body)
    assert_equal(responsejson['count'], 3)
  end

  test "should get word min" do
    get :min, format: 'json'
    assert_response :success
    assert_equal(200, @response.status)

    responsejson = JSON.parse(@response.body)
    assert_equal(responsejson['min'], 4)
  end

  test "should get word max" do
    get :max, format: 'json'
    assert_response :success
    assert_equal(200, @response.status)

    responsejson = JSON.parse(@response.body)
    assert_equal(responsejson['max'], 4)
  end

  test "should get word median" do
    get :median, format: 'json'
    assert_response :success
    assert_equal(200, @response.status)

    responsejson = JSON.parse(@response.body)
    assert_equal(responsejson['median'], 4)
  end

  test "should get word average" do
    get :average, format: 'json'
    assert_response :success
    assert_equal(200, @response.status)

    responsejson = JSON.parse(@response.body)
    assert_equal(responsejson['average'], 4)
  end
end

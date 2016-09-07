class WordsController < ApplicationController
  helper WordsHelper
  
  def index
    @words = Word.all
    respond_to do |format|
      format.json { render json: @words }
      format.xml { render xml: @words }
    end
  end

  # GET /words/1
  # GET /words/1.json
  def show
    curWord = Word.find_by_word(params[:id])
    respond_to do |format|
      format.json { render json: curWord }
    end
  end
  
  # GET /anagrams/1
  # GET /anagrams/1.json
  def anagram
    # Reduce subset of words searched by word size
    wordsubset = Word.find_all_by_wordsize(params[:id].size)

    limit = nil
    unless params[:limit].nil?
      limit = params[:limit].to_i
    end

    # Find anagrams
    anagrams = WordsHelper.findAnagrams(wordsubset, params[:id], limit)

    respond_to do |format|
      format.json { render json: anagrams }
    end
  end
  
  # POST /words
  # POST /words.json
  def create
    params[:words].each do |word|
      dbword = Word.new(:word => word)
      dbword.save
    end
    
    respond_to do |format|
      format.json { head :created }
    end
  end

  # DELETE /words/read
  # DELETE /words/read.json
  def destroy
    delword = Word.find_by_word(params[:id])
    delword.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  # DELETE /words
  # DELETE /words.json
  def destroy_all
    allwords = Word.all
    allwords.each do |word|
      word.destroy
    end
    
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  # GET /count.json
  def count
    wordcount = Word.all.size
    unless wordcount < 1
      res = {'count' => wordcount}
    end
    respond_to do |format|
      format.json { render json: res }
    end
  end
  
  # Get /count/min.json
  def min
    words = Word.all
    min = nil
    words.each do |word|
      if min.nil? || min > word.wordsize
        min = word.wordsize
      end
    end
    
    unless min.nil? || min < 1
      res = {'min' => min}
    end
    
    respond_to do |format|
      format.json { render json: res }
    end
  end

  # Get /count/max.json
  def max
    words = Word.all
    max = nil
    words.each do |word|
      if max.nil? || max < word.wordsize
        max = word.wordsize
      end
    end
    
    unless max.nil? || max < 1
      res = {'max' => max}
    end
    
    respond_to do |format|
      format.json { render json: res }
    end
  end

  # Get /count/median.json
  def median
    words = Word.all
    wordcount = []
    words.each do |word|
      wordcount << word.wordsize
    end
    
    unless wordcount.empty?
      if wordcount.size % 2 > 0
        middleleftindex = wordcount.size / 2
        middlerightindex = middleleftindex + 1
        median = (wordcount[middleleftindex] + wordcount[middlerightindex]) / 2
        res = {'median' => median}
      else
        wordindex = wordcount.size / 2
        res = {'median' => wordcount[wordindex]}
      end
    end

    respond_to do |format|
      format.json { render json: res }
    end
  end

  # Get /count/average.json
  def average
    words = Word.all
    wordcounttotal = 0
    words.each do |word|
      wordcounttotal += word.wordsize
    end
    
    unless wordcounttotal < 1
      average = wordcounttotal / words.size
      res = {'average' => average}
    end

    respond_to do |format|
      format.json { render json: res }
    end
  end
end

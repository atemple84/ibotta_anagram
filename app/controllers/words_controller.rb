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
end

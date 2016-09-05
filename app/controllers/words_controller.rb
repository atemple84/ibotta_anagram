class WordsController < ApplicationController
  
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
    curWord = params[:id]
  end
  
  # POST /words
  # POST /words.json
  def create
    params[:words].each do |word|
      dbword = Word.new(:word => word)
      dbword.save
    end
    
    respond_to do |format|
      format.json { head :ok }
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

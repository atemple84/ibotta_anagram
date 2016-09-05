class Word < ActiveRecord::Base
  attr_accessible :word, :wordsize
  validates_uniqueness_of :word, :scope => [:wordsize]
  validates_presence_of :word, :wordsize
  
  after_initialize :init

  def init
    unless self.word.nil?
      self.wordsize = self.word.size
      self.word = self.word.downcase
    end
  end
end

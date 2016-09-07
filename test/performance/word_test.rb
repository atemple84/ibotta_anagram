require 'test_helper'
require 'rails/performance_test_help'

class WordTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  #self.profile_options = { :runs => 3, :metrics => [:wall_time, :memory]
  #                          :output => 'tmp/performance', :formats => [:flat] }

  #def test_homepage
  #  get '/'
  #end

  def test_dictionary_load
    wordarray = []
    Zlib::GzipReader.open(Rails.root + 'public/dictionary.txt.gz') {|gz|
      gz.each_line do |gzline|
        wordarray << gzline
      end
    }
        
    post :create, words: wordarray, format: 'json'
    assert_response :success
  end
end

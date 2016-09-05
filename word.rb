require 'set'
require 'zlib'

class Word
  def initialize
    if (defined?(@@wordmap)).nil?
      loadMap
    else
      testWordMap
    end
  end
  
  def loadMap
    @@wordmap = {}
    Zlib::GzipReader.open(Rails.root + 'public/dictionary.txt.gz') {|gz|
      gz.each_line do |gzline|
        if (@@wordmap.key?(gzline.size))
          @@wordmap[gzline.size].add(gzline)
        else
          @@wordmap[gzline.size] = SortedSet.new [gzline]
        end
      end
    }
  end

  def testWordMap
    puts @@wordmap[5].to_a
  end
end
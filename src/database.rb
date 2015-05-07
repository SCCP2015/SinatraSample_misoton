# coding: utf-8
require 'singleton'

class Database 
  include Singleton
  DATA_FILE = "data"
  
  def addData(word)
   if File.exist?(DATA_FILE) and word
      data = File.read(DATA_FILE)
      File.write(DATA_FILE, data + word + "\n")
      data + word + "\n"
    else
      File.write(DATA_FILE, word + "\n")
      word + "\n"
    end
  end

  def cleanData()
    File.write(DATA_FILE, "") 
    ""
  end

  def readData()
    if File.exist?(DATA_FILE)
      File.read(DATA_FILE)
    else
      ""
    end
  end
end

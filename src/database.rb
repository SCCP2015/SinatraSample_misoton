# coding: utf-8
require 'singleton'

class Database 
  include Singleton
  DATA_FILE = "data"
  
  def addData(word)
   if File.exist?(DATA_FILE) and word
      data = File.read(DATA_FILE)
      File.write(DATA_FILE, data + word + "\n")
      data + word
    else
      File.write(DATA_FILE, word + "\n")
      word
    end
  end

  def cleanData()
    File.write(DATA_FILE, "") 
    "\n"
  end

  def readData()
    if File.exist?(DATA_FILE)
      File.read(DATA_FILE) + "\n"
    end
  end
end

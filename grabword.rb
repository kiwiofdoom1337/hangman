class Grabword
  def initialize
    @file = 'dictionary.txt'
  end

  def words
    File.readlines(@file).select {|element| element.length >= 6 }
  end

  def random_word(arr)
    arr.sample    
  end
end
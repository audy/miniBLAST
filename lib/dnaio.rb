class DnaIO # iterator
  def initialize(handle, args={})
    @handle = handle
  end
  
  def each
    sequence, header = nil, nil
    @handle.each do |line|
      if line[0] == '>'
        yield Dna.new(:name => header, :sequence => sequence) if sequence
        sequence = ''
        header = line[1..-1].strip
      else
        sequence << line.strip.tr(' ','')
      end
      yield Dna.new(:name => header, :sequence => sequence)
    end
    
  end

end

class Dna # nucleotide record
  attr_accessor :name, :sequence
  
  def initialize(args={})
    @name = args[:name]
    @sequence = args[:sequence]
  end
  
  def to_s
    ">#{@name}\n#{@sequence}\n"
  end
  
  def length
    @sequence.length
  end
end
class Equation
  attr_accessor :genes

  def self.run(number = 100)
    colony = generate(number)
    while colony.max.fitness != 1/0
      puts "Best: #{colony.max.equation}=#{colony.max.evaluate}"
      colony = next_generation(colony)
    end
    puts "Found: #{colony.max.equation}=#{colony.max.evaluate}"
  end
  
  def self.generate(number = 100)
    (0..number).collect do
      Equation.new
    end
  end

  def self.naturally_select(collection)
    total_fitness = collection.collect {|c| c.fitness}.inject {|a,b|a+b}
    roulette_arrow = rand * total_fitness
    collection.each do |c|
      roulette_arrow -= c.fitness
      return c if roulette_arrow <= 0
    end
    return nil
  end

  def self.select_perfect(collection)
    collection.select {|c| c.fitness == 1/0 }
  end

  def self.next_generation(collection)
    (0..collection.size).collect do
      naturally_select(collection).breed(naturally_select(collection))
    end
  end

  
  def initialize(genes = nil)
    @genes = genes || (0..(NUMBER_OF_GENES*GENE_LENGTH)).collect do
      rand(2) 
    end.join
  end

  def <=>(other)
    fitness <=> other.fitness
  end
  

  NUMBER_OF_GENES = 9
  GENE_LENGTH = 4
  TRANSLATE = {
    "0000" => 0,
    "0001" => 1,
    "0010" => 2,
    "0011" => 3,
    "0100" => 4,
    "0101" => 5,
    "0110" => 6,
    "0111" => 7,
    "1000" => 8,
    "1001" => 9,
    "1010" => :"+",
    "1011" => :"-",
    "1100" => :"*",
    "1101" => :"/",
  }

  def equation
    string = (0...NUMBER_OF_GENES).collect do |i| 
      TRANSLATE[@genes[i*GENE_LENGTH...(i+1)*GENE_LENGTH]]
    end.join
  end
  
  def evaluate
    begin
      eval(equation).to_f
    rescue SyntaxError, NoMethodError, TypeError, ZeroDivisionError
    end
  end

  def fitness
    if evaluate == nil
      0
    else
      (1 / (42 - evaluate)).abs
    end
  end

  def breed(other)
    if rand < 0.7
      slice_point = rand(GENE_LENGTH*NUMBER_OF_GENES)
      new_genes = @genes[0..slice_point] + other.genes[(slice_point+1)..-1]
      if rand < 0.01
        puts "Mutating: #{new_genes}"
        gene_index = rand(GENE_LENGTH)
        new_genes[gene_index] = new_genes[gene_index].chr == '0' ? '1' : '0'
        puts "        : " + (" "*gene_index) + "|"
        puts "Mutated : #{new_genes}"
      end
      Equation.new(new_genes)
    else
      Equation.new(@genes)
    end
  end
end

class Fixnum
  def /(other)
    to_f / other.to_f
  end
end
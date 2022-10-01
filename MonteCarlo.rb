class MonteCarloMethod

  prob_array = []
  poglochenie = 0
  n1 = 0
  m1 = 0
  peace_ns = 0
  north = 0
  east = 0
  west = 0
  south = 0
  x = 0
  у = 0


  attr_accessor :x_loc, :y_loc, :is_poglochenie
  def initialize(var_x, var_y)
    @x_loc = var_x
    @y_loc = var_y
    @is_poglochenie = false
  end
  while 1
    begin
      puts "-----Enter the quantity of pieces-----"
      peace_ns = Integer(STDIN.gets.chomp)
      break
    rescue ArgumentError
      puts "You entered wrong number, please repeat the action"
    end
  end

  while 1
    begin
      puts "-----Grid size N (west -> east):-----"
      n1 = Integer(STDIN.gets.chomp)
      break
    rescue ArgumentError
      puts "You entered wrong number, please repeat the action"
    end
  end

  while 1
    begin
      puts "-----Grid size M (north -> south):-----"
      m1 = Integer (STDIN.gets. chomp)
      break
    rescue ArgumentError
      puts "You entered wrong number, please repeat the action"
    end
  end

  while 1
    begin
      puts "-----Start n0:-----"
      x = Integer (STDIN.gets.chomp)
      if x > n1
        puts "Error! Requirement: n0>N"
      else
        break
      end
    rescue ArgumentError
      puts "You entered wrong number, please repeat the action"
    end
  end


  while 1
    begin
      puts "-----Start m0-----"
      y = Integer (STDIN.gets.chomp)
      if y > m1
        puts "Error! Requirement: m0>M"
      else
        break
      end
    rescue ArgumentError
      puts "You entered wrong number, please repeat the action"
    end
  end

  for i in 1..5
    while 1
      if i <= 4
        puts ("Probability P#{i}")
      else
        puts ("Probability Ра (poglochenie)")
      end
      choose = STDIN.gets.chomp.to_f
      if choose >= 1 || choose < 0
        puts "Error! Probability < 0 or Probability >1, please repeat an action:"
      else
        prob_array << choose
        puts ("Values left: #{(1 - prob_array.inject(:+)).round(4)}")
        break
      end
    end
  end

  if prob_array.sum != 1
    puts "The sum of Probability cannot be more than one. Please restart the program!"
    abort
  end

  def check_movement (prob_array)
    temp = rand
    if temp < prob_array[0]
      @y_loc += 1
    elsif temp < prob_array[0] + prob_array[1]
      @y_loc -= 1
    elsif temp < prob_array[0] + prob_array[1] + prob_array[2]
      @x_loc += 1
    elsif temp < prob_array[0] + prob_array[1] + prob_array[2] + prob_array[3]
      @x_loc -= 1
    else
      @is_poglochenie = true
    end
  end


  for i in 1..peace_ns
    obj = MonteCarloMethod.new(x, y)
    while obj.x_loc < n1 and obj.x_loc > 0 and obj.y_loc <
      m1 and obj.y_loc > 0 and obj.check_movement (prob_array)
    end

    if obj.is_poglochenie
      poglochenie += 1
    else
      if obj.x_loc == n1
        east += 1
      elsif obj.x_loc == 0
        west += 1
      elsif obj.y_loc == m1
        north += 1
      elsif obj.y_loc == 0
        south += 1
      end
    end
  end

  q_var1 = north.to_f / peace_ns.to_f
  q_var2 = south.to_f / peace_ns.to_f
  q_var3 = east.to_f / peace_ns.to_f
  q_var4 = west.to_f / peace_ns.to_f
  q_var_a = poglochenie.to_f / peace_ns.to_f
  uns_1 = Math.sqrt(q_var1 * (1 - q_var1) / peace_ns.to_f)
  uns_2 = Math.sqrt(q_var2 * (1 - q_var2) / peace_ns.to_f)
  uns_3 = Math.sqrt(q_var3 * (1 - q_var3) / peace_ns.to_f)
  uns_4 = Math.sqrt(q_var4 * (1 - q_var4) / peace_ns.to_f)
  uns_a = Math.sqrt(q_var_a * (1 - q_var_a)/peace_ns.to_f)
  puts "-----Your Results-----"
  puts ("The average number Q1 (North) is #{q_var1.round(5)} -> #{uns_1.round (5)}")
  puts ("The average number Q2 (South) is #{q_var2.round(5)} -> #{uns_2.round (5)}")
  puts ("The average number Q3 (East) is #{q_var3.round(5)} -> #{uns_3.round (5)}")
  puts ("The average number Q4 (West) is #{q_var4.round(5)} -> #{uns_4.round (5)}")
  puts ("The average number Qa (Stopped) is #{q_var_a.round(5)} -> #{uns_a. round (5)}")
end
class Employee
  attr_accessor :boss
  attr_reader :salary

  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss =
      name, title, salary, boss

    assign_boss(boss) unless @boss.nil?
  end

  def assign_boss(cur_boss)
    until cur_boss.nil?
      cur_boss.add_employee(self)
      cur_boss = cur_boss.boss
    end
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end

class Manager < Employee

  def initialize(name, title, salary, boss)
    @employees = []
    super
  end

  def bonus(multiplier)
    @employees.map(&:salary).reduce(:+) * multiplier
  end

  def add_employee(employee)
    @employees << employee
    employee.boss = self
  end

end

ned = Manager.new("Ned", "Founder", 1_000_000, nil)
darren = Manager.new("Darren", "TA Manager", 78_000, ned)
shawna = Employee.new("Shawna", "TA", 12_000, darren)
david = Employee.new("David", "TA", 10_000, darren)

p ned.bonus(5) == 500_000
p darren.bonus(4) == 88_000
p david.bonus(3) == 30_000

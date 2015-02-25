class Employee
  attr_reader :salary
  attr_accessor :boss
  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss =  name, title, salary, boss
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :boss, :employees
  def initialize(name, title, salary, boss, employees)
    @employees = employees
    super(name, title,salary, boss)
  end

  def bonus(multiplier)
    bonus =  employees.inject(0){|sum, employee| sum + employee.salary}
    bonus *= multiplier
  end

  private

  def total_salary(employee)
  end
end

shawna = Employee.new("Shawna", "TA", 10_000, nil )
darren = Manager.new("Darren", "TA Manager", 78_000, nil, nil)
ned = Manager.new("Ned", "Founder", 1_000_000, nil, nil)

shawna.boss = darren
darren.boss = ned
darren.employees = [shawna]
ned.employees = [darren, shawna]

p ned.bonus(5)
p darren.bonus(4)
p shawna.bonus(3)

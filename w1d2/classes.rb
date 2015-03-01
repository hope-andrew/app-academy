class Student

  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
  end

  def name
    "#{@first} #{@last}"
  end

  def courses
    @courses
  end

  def enroll(course)
    unless (course.students).include?(self.name)
      @courses << course
      course.students << self.name
    end
  end

  def course_load
    loads = Hash.new(0)

    @courses.each do |course|
      loads[course.department] += course.units
    end

    loads
  end
end

class Course
  attr_reader :course_name, :department, :units
  attr_accessor :students

  def initialize(course_name, department, units)
    @course_name = course_name
    @department = department
    @units = units
    @students = []
  end

  def students
     @students
  end

  def add_student(student)
    @students << student
  end
end


brian = Student.new("Brian", "Smith")
mary = Student.new("Mary", "Smith")
john = Student.new("John", "Smith")

physics0 = Course.new('Physics 101', 'Physics', 3)
physics1 = Course.new('Physics 102', 'Physics', 4)
physics2 = Course.new('Physics 102', 'Math', 4)
physics3 = Course.new('Physics 301', 'Chemistry', 4)

brian.enroll(physics0)
brian.enroll(physics1)

# p brian.courses
# p physics1.students

brian.enroll(physics1)
mary.enroll(physics1)
john.enroll(physics1)
# p physics1.students
brian.enroll(physics2)
brian.enroll(physics3)
# p physics1.students
# puts "-------------"
p brian.course_load

def input_students

  # while the name is not empty, repeat this code

  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = gets.chomp
  students = []

  while !name.empty? do
  
    # add the student hash to the array
        
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"

    name = gets.chomp
         
  end
  
  # return the array of students

  return students

end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print(students)
  students.each { |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  }
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end


students = input_students
print_header
print(students)
print_footer(students)

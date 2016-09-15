def input_students
  months = ["january", "february", "march", "april", "may", "june", 
            "july", "august", "september", "october", "november", "december"]

  puts "to finish, just hit return twice"
  students = []

  loop do
    print "Please enter the name of the student: "
    name = gets.chomp
    if name.empty?
      break
    end

    print "What cohort should I add #{name} to?: "
    cohort = gets.chomp

    if cohort == ""
      cohort = "november"
    end

    if cohort != ""

      until months.any? {|month| cohort == month} 
        puts "please enter a valid month"
        cohort = gets.chomp
      end

    end



    print "What are #{name}'s hobbies?: "
    hobbies = gets.chomp
    print "What is #{name}'s country of birth? "
    country = gets.chomp

    students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, country: country}
    if students.count == 1
      puts "Now we have #{students.count} student".center(100)
      puts ""
    else
      puts "Now we have #{students.count} students".center(100)
      puts ""
    end
  end

  return students

end


def output_header(students)
  if students.count == 0
    puts "There are no students yet".center(100)
  else
    puts "The students of Makers Academy".center(100)
    puts "-------------".center(100)
  end
end

def output(students)
  students.each_with_index {|student, index|
    if student[:name].length < 12
      puts "#{index + 1}. #{student[:name]} is from #{student[:country]} and registered in the #{student[:cohort]} cohort.".center(100)
      if student[:hobbies] != ""
        puts "#{student[:name]} likes to #{student[:hobbies]}".center(100)
        puts ""
      end
    end
  }
end

def output_footer(students)
  if students.count == 0
    puts ""
  elsif students.count == 1
    puts "Overall, we have #{students.count} great student!".center(100)
  else
  puts "Overall, we have #{students.count} great students!".center(100)
  end
end

def select_cohort(students)
  print "what cohort would you like to select? "
  month = gets.chomp.downcase.to_sym
  selected_cohort = students.select {|student|
   if student[:cohort] == month
      puts ""
      puts "#{student[:name]}: #{student[:cohort]} cohort".center(100)
   end
  }
  return selected_cohort
end

def student_finder(students)
  print "What is the first letter of the student's name?: "
  letter = gets.chomp.downcase
  selected_students = students.select { |student|
    if student[:name][0] == letter
      puts ""
      puts "#{student[:name]}: #{student[:cohort]} cohort".center(100)
    end
  }
  return selected_students
end


students = input_students
puts ""
puts ""

output_header(students)

output(students)
puts ""

output_footer(students)
puts ""

if students.count > 0
  puts "Would you like to search by cohort name?"
  answer = gets.chomp
  if answer == "yes"
    select_cohort(students)
  end
end

if students.count > 0
  puts "Would you like to search for a student by name?"
  answer = gets.chomp
    if answer == "yes"
    student_finder(students)
    end

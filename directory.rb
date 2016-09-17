
@students = []

def input_students
  months = ["January", "February", "March", "April", "May", "June", 
            "July", "August", "September", "October", "November", "December"]
  
  print "Please enter the name of the student: "
  puts "To finish, just hit return twice"

  loop do   
    name = gets[0...-1]
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

      @students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, country: country}
      
      if @students.count == 1
        puts "Now we have #{@students.count} student".center(100)
        puts ""
      else
        puts "Now we have #{@students.count} students".center(100)
        puts ""
    end
  end
end

def interactive_menu
    loop do 
      print_menue
      process(gets.chomp)
   end
end

def print_menue
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
  end

def show_students
      output_header
      output
      output_footer
  end

def process(selection)
case selection
      when "1"
        #input the students
      input_students
      when "2"
        #show the students
        show_students
      when "9"
        exit #this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
   end
 end 

def output_header
  if @students.count == 0
    puts "There are no students yet".center(100)
  else
    puts "The students of Makers Academy".center(100)
    puts "-------------".center(100)
  end
end

def output
  @students.each_with_index {|student, index|
    if student[:name].length < 12
      puts "#{index + 1}. #{student[:name]} is from #{student[:country]} and registered in the #{student[:cohort]} cohort.".center(100)
      if student[:hobbies] != ""
        puts "#{student[:name]} likes to #{student[:hobbies]}".center(100)
        puts ""
      end
    end
  }
end

def output_footer
  if @students.count == 0
    puts ""
  elsif @students.count == 1
    puts "Overall, we have #{@students.count} great student!".center(100)
  else
  puts "Overall, we have #{@students.count} great students!".center(100)
  end
end

def select_cohort
  print "what cohort would you like to select? "
  month = gets.chomp.downcase.to_sym
  selected_cohort = @students.select {|student|
   if student[:cohort] == month
      puts ""
      puts "#{student[:name]}: #{student[:cohort]} cohort".center(100)
   end
  }
  return selected_cohort
end

def student_finder
  print "What is the first letter of the student's name?: "
  letter = gets.chomp.downcase
  selected_students = @students.select { |student|
    if student[:name][0] == letter
      puts ""
      puts "#{student[:name]}: #{student[:cohort]} cohort".center(100)
    end
  }
  return selected_students
end
=begin
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
end

=end

interactive_menu

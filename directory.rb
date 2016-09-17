
@students = []

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list to students.csv"
    puts "9. Exit"
end

def interactive_menu
    loop do 
      print_menu
      process(STDIN.gets.chomp)
    end
end

def process(selection)
case selection
      when "1"
        input_students
      when "2"
        show_students
      when "3"
        save_students
      when "4"
        load_students
      when "9"
        exit #this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
    end
 end 

def input_students
  months = ["January", "February", "March", "April", "May", "June", 
            "July", "August", "September", "October", "November", "December"]
  
  puts "Please enter the name of the student: "
  puts "To finish, just hit return twice"

 loop do  
  puts "Add another student" 
    name = STDIN.gets[0...-1]
      if name.empty?
        break
      end

      print "What cohort should I add #{name} to?: "
      cohort = STDIN.gets.chomp

      if cohort == ""
         cohort = "(none listed)"
      end

      if cohort != ""
        until months.any? {|month| cohort == month 
          puts "please enter a valid month"
          cohort = STDIN.gets.chomp
         }
      end

      print "What are #{name}'s hobbies?: "
      hobbies = STDIN.gets.chomp

      if hobbies == ""
        hobbies= "(none listed)"
      end

      print "What is #{name}'s country of birth? "
      country = STDIN.gets.chomp

      if country == ""
        country = "(none listed)"
      end

      add_students(name, cohort, hobbies, country)
      
      if @students.count == 1
        puts "Now we have #{@students.count} student".center(100)
        puts ""
      else
        puts "Now we have #{@students.count} students".center(100)
        puts ""
      end
    end
  end
end 

def show_students
      output_header
      output
      output_footer
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
    puts "There are no students registered"
  elsif @students.count == 1
    puts "Overall, we have #{@students.count} great student!".center(100)
  else
  puts "Overall, we have #{@students.count} great students!".center(100)
  end
end

def select_cohort
  print "what cohort would you like to select? "
  month = STDIN.gets.chomp.downcase.to_sym
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
  letter = STDIN.gets.chomp.downcase
  selected_students = @students.select { |student|
    if student[:name][0] == letter
      puts ""
      puts "#{student[:name]}: #{student[:cohort]} cohort".center(100)
    end
  }
  return selected_students
end

def save_students
  # open the file for writing.
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do | student|
    student_data = [student[:name], student[:cohort], student[:hobbies], student[:country]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort, hobbies, country = line.chomp.split(',')
  add_students(name, cohort, hobbies, country)
  end 
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil?
  filename = "students.csv" # get out of the method if it isn't given
  end
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def add_students(name, cohort, hobbies, country)
  @students << {name: name, cohort: cohort.to_sym, hobbies: hobbies, country: country}
end

try_load_students
interactive_menu

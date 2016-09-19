
#We are de-facto using CSV format to store data. 
#However, Ruby includes a library to work with the CSV files that we could use instead of working directly with the files. 
#Refactor the code to use this library.
require 'csv'
@students = []

def print_menu

   puts "1. Input the students"
   puts "2. Show the students"
   puts "3. Save the list to students.csv"
   puts "4. Load the list to students.csv"
   puts "5. Select by cohort"
   puts "6. Select student by letter"
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
        puts
        puts "To view your students go back to the main menu and press 1"
      when "2"
        show_students
      when "3"
        save_students
      when "4"
        load_students
        puts
        puts "Your file has been loaded"
        puts
      when "5"
        select_cohort
      when "6"
        student_finder
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
      
      break if name.empty?

    puts "What cohort are they on?".center(100)

    cohort = STDIN.gets.chomp
        if cohort == ""
           cohort = "(none listed)"
                
                else
        
                until months.any?{|valid_month| cohort == valid_month} 

                puts "Incorrect spell. Please try again".center(50)

                cohort = STDIN.gets.chomp
              end
          end


      puts "What are #{name}'s hobbies?: "
      hobbies = STDIN.gets.chomp

      if hobbies == ""
         hobbies = "(none listed)"
      end

      puts "What is #{name}'s country of birth? "
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

def show_students
      print_header
      print_output
      print_footer
end

def print_header
  if @students.count == 0
    puts "There are no students yet".center(100)
  else
    puts "The students of Makers Academy".center(100)
    puts "-------------".center(100)
  end
end

def print_output
  @students.each_with_index {|student, index|
    if student[:name].length < 12
      puts 
      puts "#{index + 1}. #{student[:name]} is from #{student[:country]} and registered in the #{student[:cohort]} cohort.#{student[:name]} likes to #{student[:hobbies]}".center(100)
        puts ""
      end
    }
end

def print_footer
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
  month = STDIN.gets.chomp.to_sym
   @students.select {|student|
   if student[:cohort] == month
      puts
      puts "#{student[:name]} is from #{student[:country]} and registered in the #{student[:cohort]} cohort. #{student[:name]} likes to #{student[:hobbies]}"
      puts 
   end
  } 
end


def student_finder
  print "What is the first letter of the student's name?: "
  letter = STDIN.gets.chomp.upcase
  selected_students = @students.select { |student|
    if student[:name][0] == letter
      puts ""
      puts "#{student[:name]} is from #{student[:country]} and registered in the #{student[:cohort]} cohort.#{student[:name]} likes to #{student[:hobbies]}"
    end
  }
end

def store_students(name, cohort)
  @students << { name: name, 
    cohort: cohort.to_sym

  }

end 

def save_students
  puts 'What would you like to name your file?'
  filename = STDIN.gets.chomp
  
  if filename.empty?
     filename = "students.csv"
  end

  # open the file for writing.
  file = CSV.open(filename, "w") do |csv|
    @students.each do |student| 
    student_data = [student[:name], student[:cohort], student[:hobbies], student[:country]]
    csv << student_data
  end
  end
 puts "Your file has been saved as #{filename}"
end


def load_students(filename = "students.csv")
  #file = CSV.open(filename, "r") do |file|
   CSV.foreach(filename) do |line|
    name, cohort = line
      store_students(name, cohort)
  end 
end 
  #file.readlines.each {|line|
  #name, cohort, hobbies, country = line.chomp.split(",")
  
    #add_students(name, cohort, hobbies, country)




=begin
def load_students(filename = "students.csv")
  file = CSV.open(filename, "r") do |file|
    
    CSV.read(file) do |row|
      puts row
    end 

    #file.readlines.each do |line|
    #name, cohort, hobbies, country = line.chomp.split(',')
    add_students(name, cohort, hobbies, country) 
  end    
end
=end

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


  
#try_load_students
interactive_menu

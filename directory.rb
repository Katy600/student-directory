
MONTHS = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
def input_students
	puts
 
	puts "Please enter the names of the students".center(50)
	puts "To finish, just hit return twice".center(50)

students = []

	loop do 

		puts "Enter the students name.".center(50)

		name = gets.chomp.capitalize

		break if name.empty?

		puts "What cohort are they on?".center(50)

		month = gets.chomp
			if month == ""
			   month = "(no month has been entered)"
			 else
				
				until MONTHS.any?{|valid_month| month == valid_month} 

				puts "Incorrect spell. Please try again".center(50)

				month = gets.chomp
				end

			end

		puts "What is their hobby?".center(50)

		hobby = gets.chomp
			if hobby == ""
			   hobby = "(no hobbies entered)"
			end

		puts "What country are they from?".center(50)

		country = gets.chomp
			if country == ""
				country = "(no country entered)"
				
			end


		students << {name: name.to_sym, cohort: month.to_sym, hobby: hobby.to_sym, country: country.to_sym}


		end 

students

end

def names_with_letter(students)
  print "What is the first letter of the student's name?: "
  letter = gets.chomp.capitalize
  selected_students = students.select { |student|
    if student[:name][0] == letter
      puts ""
      puts "#{student[:name]} is on the #{student[:cohort]} cohort. They enjoy #{student[:hobby]} in their spare time and they come from #{student[:country]}.".center(50)
		end
    end
  }
  #return selected_students
end


def group_in_cohort(students)
	puts "What cohort would you like to look at?"

	cohort = gets.chomp.capitalize
	selected_student = students.select do |student| 
		if student[:cohort] == cohort 
		
		puts ""
		puts "#{student[:name]} is on the #{student[:cohort]} cohort. They enjoy #{student[:hobby]} in their spare time and they come from #{student[:country]}.".center(50)
		
		else
			"There are no students in this cohort"

		end 
	end 	
end 

	
def print_header
	puts "The students of my cohort at Makers Academy".center(50)
	puts "--------------".center(50)
end

def print(students)
		students.each_with_index do |student, index|
		puts "#{index + 1}. #{student[:name]} is on the #{student[:cohort]} cohort. They enjoy #{student[:hobby]} in their spare time and they come from #{student[:country]}.".center(50)
	end
end

def print_footer(students)
	if students.count > 1
		puts "Overall, we have #{students.count} great students".center(50)
	elsif students.count == 1
		puts "Overall, we have 1 great student".center(50)
	else
		puts "No students have been entered"
	end 
end
#nothing happens until we call the methods


students = input_students
print_header
print(students)
print_footer(students)
group_in_cohort(students)
names_with_letter(students)





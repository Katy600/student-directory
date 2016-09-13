def input_students
 
	puts "Please enter the names of the students"
	puts "To finish, just hit return twice"
	#create an empty array
	students = []
	#get the first name
	loop do
	puts "What is the next students name?"
	name = gets.chomp
	if name.empty?
		break
	end

	puts "What is their hobby?"
	hobby = gets.chomp

	puts "What is their country of origin?"
	country = gets.chomp

	
		students << {name: name, cohort: :november, hobbies: hobby, country_of_birth: country}
		puts "Now we have #{students.count} students"
	end
	
	return students
end

def print_header
	puts "The students of my cohort at Makers Academy"
	puts "--------------"
end

def print(students)
		students.each_with_index do |student, index|
		puts "#{index + 1}. #{student[:name]} #{student[:cohort]} cohort. They enjoy #{student[:hobbies]} in their spare time and they come from #{student[:country_of_birth]}"
	end
end

def print_footer(students)
	puts "Overall, we have #{students.count} great students"
end
#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
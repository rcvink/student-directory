def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_all_students(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_for_letter(students, letter)
  students.each_with_index do |student, index|
    puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name][0].upcase == letter.upcase
  end
end

def print_with_char_limit(students, characters)
  students.each_with_index do |student, index|
    puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].length < characters
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print_all_students(students)
print_footer(students)

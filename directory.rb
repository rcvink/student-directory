def input_students
  puts "Please enter the names of the students, their cohort, and their place of birth"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # get the cohort
  cohort = gets.chomp
  if cohort.empty?
    cohort = "November"
  end
  # get the country of birth
  birthplace = gets.chomp
  # while the name is not empty, repeat this codes
  while !(name.empty? || birthplace.empty?) do
    # add the student hash to the array
    students << {name: name, cohort: cohort.to_sym, birthplace: birthplace.to_sym}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
    cohort = gets.chomp
    if cohort.empty?
      cohort = "November"
    end

    birthplace = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_all_students(students)
  if students.length == 0
    puts "There are no students at Villains Academy!"
  else
    index = 0
    until index == students.length
      puts "#{index + 1}. name: #{students[index][:name].center(20)} | cohort: #{students[index][:cohort].to_s.center(12)} | country: #{students[index][:birthplace].to_s.center(15)}"
      index += 1
    end
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
  footer_message = "Overall, we have #{students.count} great student"
  if students.count > 1
    puts footer_message + "s"
  else
    puts footer_message
  end
end

students = input_students
print_header
print_all_students(students)
print_footer(students)

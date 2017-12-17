def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will terminate the program
    else
      puts "I don't know what you meant, try again"
    end
  end
end

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

def print(students)
  if students.length == 0
    puts "There are no students at Villains Academy!"
  else
    students.each_with_index do |student, index|
      puts "#{index + 1}. name: #{student[:name].center(20)} | cohort: #{student[:cohort].to_s.center(12)} | country: #{student[:birthplace].to_s.center(15)}"
    end
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

interactive_menu

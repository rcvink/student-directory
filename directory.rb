@students = [] #an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit # this will terminate the program
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def input_students
  puts "Please enter the names of the students, their cohort, and their place of birth"
  puts "To finish, just hit return twice"
  # get the first name
  name = gets.chomp
  # get the cohort, set to November if no input
  cohort = gets.chomp
  if cohort.empty?
    cohort = "November"
  end
  # get the country of birth
  birthplace = gets.chomp
  # while the name or birthplace are not empty, repeat this:
  while !(name.empty? || birthplace.empty?) do
    # add the student hash to the array
    @students << {name: name, cohort: cohort.to_sym, birthplace: birthplace.to_sym}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = gets.chomp
    cohort = gets.chomp
    if cohort.empty?
      cohort = "November"
    end
    birthplace = gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  if @students.length == 0
    puts "There are no students at Villains Academy!"
  else
    @students.each_with_index do |student, index|
      puts "#{index + 1}. name: #{student[:name].center(20)} | cohort: #{student[:cohort].to_s.center(12)} | country: #{student[:birthplace].to_s.center(15)}"
    end
  end
end

def print_footer
  footer_message = "Overall, we have #{@students.count} great student"
  if @students.count > 1
    puts footer_message + "s"
  else
    puts footer_message
  end
end

interactive_menu

@students = [] #an empty array accessible to all methods

## Menu methods

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to disk"
  puts "4. Load the list from disk"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    puts "Enter a filename to save to (or `return` for students.csv)"
    save_students(STDIN.gets.chomp)
  when "4"
    puts "Enter a filename to load from (or `return` for students.csv)."
    load_students(STDIN.gets.chomp)
  when "9"
    puts "Terminating program.."
    exit # this will terminate the program
  else
    puts "I don't know what you meant, try again."
  end
end

## Input methods

def input_students
  puts "Please enter the names of the students and their cohort."
  puts "To finish, just hit return twice."
  name, cohort = ask_for_student
  # while the name is not empty, repeat this:
  while !name.empty? do
    # add the student hash to the array
    add_student(name, cohort)
    puts "Now we have #{@students.count} students."
    # get another name from the user
    name, cohort = ask_for_student
  end
  puts "Finished inputting students."
end

def ask_for_student
  name = STDIN.gets.chomp
  cohort = STDIN.gets.chomp
  if cohort.empty?
    cohort = "November"
  end
  return name, cohort
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

## Printing methods

def show_students
  print_header
  print_students_list
  print_footer
  puts "All students printed."
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
      puts "#{index + 1}. name: #{student[:name].center(20)} | cohort: #{student[:cohort].to_s.center(12)}"
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

## Save/Load methods

def save_students(filename)
  if filename.empty?
    filename = "students.csv"
  end
  # open the file for writing
  File.open(filename, "w") do
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      File.puts csv_line
    end
  end
  puts "Successfully saved file to students.csv."
end

def load_students_on_startup
  filename = ARGV.first # first argument from the command line
  if filename.nil?
    load_students("students.csv")
    return
  end
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def load_students(filename)
  if filename.empty?
    filename = "students.csv"
  end
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student(name, cohort)
  end
  puts "Successfully loaded file #{filename}."
end

load_students_on_startup
interactive_menu

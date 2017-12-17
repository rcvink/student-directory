@students = [] #an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
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
    exit # this will terminate the program
  else
    puts "I don't know what you meant, try again"
  end
end

def ask_for_student
  name = STDIN.gets.chomp
  cohort = STDIN.gets.chomp
  if cohort.empty?
    cohort = "November"
  end
  return name, cohort
end

def input_students
  puts "Please enter the names of the students and their cohort"
  puts "To finish, just hit return twice"
  name, cohort = ask_for_student
  # while the name is not empty, repeat this:
  while !name.empty? do
    # add the student hash to the array
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name, cohort = ask_for_student
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
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

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student(name, cohort)
  end
  file.close
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
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

try_load_students
interactive_menu

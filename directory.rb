@students = []

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "Loaded #{@students.count} students from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

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
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "Please enter the name of the student"
  name = STDIN.gets.delete "\n"
  puts "what cohort? (optional - to skip hit enter)"
  month = STDIN.gets.chomp.to_sym
  puts month
  month = :november if month.empty?

  while !name.empty? do  
    @students << {name: name, cohort: month, country: :Neverland, hobby: :mischief}
    puts "Now we have #{@students.count} student#{@students.count != 1? 's':''}."
    puts "To finish the list, hit return twice"
    # get another name from the user
    puts "next name?"
    name = STDIN.gets.delete "\n"
    puts "their cohort?"
    month = STDIN.gets.chomp.to_sym
    month = :november if month.empty?
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Random Academy"
  puts "-------------"
end

def print_students_list
    if @students.empty?
        puts "No students :("
    else
      @students.each_with_index do |student, index|
        if student[:name][0].downcase == 'a' && student[:name].length < 12
            puts "#{index+1}. #{student[:name].center(12)} (#{student[:cohort]} cohort) from #{student[:country]}. Hobby: #{student[:hobby]}"
        end
      end
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end 

def print_cohort
    if @students.empty?
        puts "No students :("
    else
        #create a list (array) of the various cohorts in the student directory
        cohort_months = []
        @students.each do |student|
            unless cohort_months.include?(student[:cohort])
                cohort_months << student[:cohort]
            end
        end
        puts cohort_months
        
        #create an array of students in a given cohort
        cohort_months.each do |cohort_month|
            puts "The #{cohort_month} cohort: "
            @students.each do |student|
                puts "#{student[:name]} (#{student[:cohort]} cohort) from #{student[:country]}. Hobby: #{student[:hobby]}" if student[:cohort] == cohort_month
            end
        end
    end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

try_load_students
interactive_menu

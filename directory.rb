require 'csv'
@students = []

def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil?
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
  puts "3. Save the list of students"
  puts "4. Load the list of students"
  puts "9. Exit"  
end

def process(selection)
  case selection
    when "1"
      puts "You chose 1: Input students"
      input_students
    when "2"
      puts "You chose 2: Show students"
      show_students
    when "3"
      puts "You chose 3: Save students"
      save_students(choose_file)
    when "4"
      puts "You chose 4: Load students"
      load_students(choose_file)
    when "9"
      puts "You chose 9: Exit program"
      exit
    else
      puts "I don't know what you mean, try again"
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

def save_students(filename)
  CSV.open(filename, "wb") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort], student[:country], student[:hobby]]
    end
  end
end

def input_students
  puts "Here you can enter the details of the student"
  puts "Format: name, cohort, country, hobby. Only name is required"
  input = 'not9'

  while input != '9' do  
    add_student(STDIN.gets)
    puts "Now we have #{@students.count} student#{@students.count != 1? 's':''}."
    puts "Next student? If you're done, choose 9."
    input = STDIN.gets.chomp
  end
end

def load_students(filename)
  CSV.foreach(filename) do |row|
    add_student(row.join(','))
  end
end

def add_student(input)
    name, cohort, country, hobby = input.chomp.split(',')
    cohort = "November" if cohort == nil
    country = "Unkown country" if country == nil
    hobby = "Hobbies unspecified" if hobby == nil
    @students << {name: name, cohort: cohort.to_sym, country: country.to_sym, hobby: hobby}
end

def choose_file
    puts "What file should we use?"
    filename = STDIN.gets.chomp
end

try_load_students
interactive_menu

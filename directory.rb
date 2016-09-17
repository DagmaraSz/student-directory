def input_students
  puts "Please enter the name of the student"
  students = []
  name = gets.chomp
  puts "what cohort? (optional - to skip hit enter)"
  month = gets.chomp.to_sym
  puts month
  month = :november if month.empty?

  while !name.empty? do  
    students << {name: name, cohort: month, country: :Neverland, hobby: :mischief}
    puts "Now we have #{students.count} students"
    puts "To finish the list, hit return twice"
    # get another name from the user
    puts "next name?"
    name = gets.chomp
    puts "their cohort?"
    month = gets.chomp.to_sym
    month = :november if month.empty?
  end

  students
end

def print_header
  puts "The students of Random Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, index|
    if student[:name][0].downcase == 'a' && student[:name].length < 12
        puts "#{index+1}. #{student[:name].center(12)} (#{student[:cohort]} cohort) from #{student[:country]}. Hobby: #{student[:hobby]}"
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end 


students = input_students
print_header
print(students)
print_footer(students)
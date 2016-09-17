def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  
  students = []
  name = gets.chomp

  while !name.empty? do  
    students << {name: name, cohort: :november, country: :Neverland, hobby: :mischief}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
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
        puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort) from #{student[:country]}. \nHobby: #{student[:hobby]}"
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
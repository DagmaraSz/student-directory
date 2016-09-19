# A short program that reads its own source code and prints it on the screen

#get name of currently executed file ($0 or $PROGRAM_NAME store this)
filename = $PROGRAM_NAME

#read the file and puts each line into console
File.open(filename, "r") {|file| file.readlines.each {|line| puts line}}
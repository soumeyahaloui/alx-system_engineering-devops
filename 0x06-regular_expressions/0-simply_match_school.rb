#!/usr/bin/env ruby

# Check if an argument is provided
if ARGV.length != 1
  puts "Usage: ./0-simply_match_school.rb <input_string>"
  exit 1
end

# Input string from command line argument
input_string = ARGV[0]

# Regular expression pattern to match "School"
pattern = /School/

# Check if the input string matches the pattern
if input_string =~ pattern
  puts input_string.gsub(pattern, "School$")
else
  puts "$"
end

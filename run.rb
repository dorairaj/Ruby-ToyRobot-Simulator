require_relative "toy_robot_simulator.rb"

loop do
  puts "Enter a sequence or type 'quit' to exit"
  input=gets
  break if input=="quit\n"    
  puts("Output")
  puts(ToyRobotSimulator.new.parse_commands(input))
end 
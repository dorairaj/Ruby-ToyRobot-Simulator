class ToyRobotSimulator            

# parse commands given to the robot.
  def parse_commands(input)
    commands = input.upcase.split(" ")
    x = 0
    y = 0
    placed = false  # Specifies whether robot is placed on board
    direction = ''
    output_positions=Array.new # To store positions which can be used for GUI if needed
    [commands,nil].flatten.each_cons(2) do |command,next_element|
      if command == "PLACE"
        x,y,direction,placed = validate_place(x,y,direction,placed,next_element)
      end
      if placed == true # if placed=true then MOVE,LEFT,RIGHT must be validated
        if command =="MOVE"
          x,y=move(x,y,direction)
        elsif command =="LEFT" || command =="RIGHT"
          direction = change_direction(command,direction)
        elsif command == "REPORT"
          output_positions.push("#{x},#{y},#{direction}")
        end
      end
    end
    return output_positions
  end
                
# Return updated coordinates if Move is valid else return  non-updated coordinates                
  def move (x,y,direction)
    if direction =="EAST"
      if validate(x+1) then return x+1,y end
    elsif direction =="WEST"
      if validate(x-1) then return x-1,y end
    elsif direction =="NORTH"
      if validate(y+1) then return x,y+1 end
    elsif direction =="SOUTH"
      if validate(y-1) then return x,y-1 end
    end
    return x,y
  end

# Return updated direction    
  def change_direction (turn,direction)
    if turn=="LEFT"
      if direction =="NORTH" then return "WEST" end
      if direction =="SOUTH" then return "EAST" end
      if direction =="EAST" then return "NORTH" end
      if direction =="WEST" then return "SOUTH" end
    elsif turn=="RIGHT"
      if direction =="NORTH" then return "EAST" end
      if direction =="SOUTH" then return "WEST" end
      if direction =="EAST" then return "SOUTH" end
      if direction =="WEST" then return "NORTH" end
    end
  end

# Return whether the updated coordinates will be inside the board
  def validate(coordinate)
    if coordinate >= 0 and coordinate < 5
      return true
    else
      return false
    end
  end

# Check whether string is a number
# This method is used to check a valid place to identify irrelevant inputs 
#      such as PLACE 5,F,EAST (invalid - input for place)
  def is_integer(str)
    str.to_i.to_s == str
  end
        
# Check if a place is valid and return proper coordinates, direction    
  def validate_place(x,y,direction,placed,place_position)
    params=place_position.split(',')
    if is_integer(params[0]) && is_integer(params[1]) # Checking invalid inputs
      temp_x=params[0].to_i
      temp_y=params[1].to_i
    else
      return x,y,direction,placed # Place invalid, return
    end 
      if validate(temp_x) && validate(temp_y) # Checking board boundaries
        if ['NORTH','EAST','WEST','SOUTH'].include?(params[2]) # Checking valid Directions
          x=temp_x
          y=temp_y
          direction=params[2]
          return x,y,direction,true #place is valid return updated coordinates and placed_state
        end
      end
      return x,y,direction,placed # Place invalid, return
  end



end
 
 

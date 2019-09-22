default:game

game : game.swift
	swiftc $< -o $@
	install_name_tool -add_rpath "/usr/lib/swift" $@ 
	#This shouldn't be necissary, but Catalina is broken
clean:
	rm ./game

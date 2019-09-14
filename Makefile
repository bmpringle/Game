default:game

game : game.swift
	swiftc $< -o $@
clean:
	rm ./game

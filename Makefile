.PHONY: switch home update fmt check gc

HOST   := $(shell hostname)
SWITCH := $(if $(filter Darwin,$(shell uname)),darwin,nixos)-rebuild

switch:
	sudo $(SWITCH) switch --flake .#$(HOST)

home:
	home-manager switch --flake .#$(HOST)

update:
	nix flake update

check:
	nix flake check

gc:
	nix-collect-garbage --delete-older-than 30d
	sudo nix-collect-garbage --delete-older-than 30d

#!/bin/sh

# ANSI color codes
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
RESET="\033[0m"

# OR using tput for portability (optional)
RED_TPUT=$(tput setaf 1)
GREEN_TPUT=$(tput setaf 2)
YELLOW_TPUT=$(tput setaf 3)
BLUE_TPUT=$(tput setaf 4)
MAGENTA_TPUT=$(tput setaf 5)
CYAN_TPUT=$(tput setaf 6)
RESET_TPUT=$(tput sgr0)

# A function to colorize any command output (Zsh compatible)
colorize() {
  local color=$1   # First argument is the color variable name (e.g., RED)
  shift            # Remove the color argument
  echo -e "${(P)color}$(eval "$@")${RESET}"   # Execute the command and colorize its output
}

# Example aliases for different colors
alias red_cmd='colorize RED'
alias green_cmd='colorize GREEN'
alias yellow_cmd='colorize YELLOW'
alias blue_cmd='colorize BLUE'
alias magenta_cmd='colorize MAGENTA'
alias cyan_cmd='colorize CYAN'

# For tput version, use this instead:
# alias red_cmd='colorize RED_TPUT'
# alias green_cmd='colorize GREEN_TPUT'
# alias yellow_cmd='colorize YELLOW_TPUT'
# alias blue_cmd='colorize BLUE_TPUT'
# alias magenta_cmd='colorize MAGENTA_TPUT'
# alias cyan_cmd='colorize CYAN_TPUT'

#!/bin/bash

# Set the URL for CIE login
cie_login_url="https://192.168.254.1:8090/login.xml"

# Define ANSI color codes
green='\033[0;32m'
red='\033[0;31m'
reset='\033[0m' # Reset color
# sleep 10
# Execute the command and capture the output and exit status
command_output=$(warp-cli disconnect 2>&1)
exit_status=$?

# Check if the command was successful
if [[ $exit_status -eq 0 ]]; then
	# Check if the output contains "Success" (or any other success message)
	if [[ "$command_output" == *"Success"* ]]; then
		dunstify -t 2000 "Success" "Disconnected from Warp successfully."
	else
		dunstify -t 2000 "Notice" "Disconnect command executed, but no success message found."
	fi
else
	dunstify "Error" "Failed to disconnect from Warp: $command_output"
fi

# Function to perform CIE login
cie_login() {
	local username="designathon1"
	local password="designathon1"
	local response=$(curl -k -s -X POST -d "mode=191&username=$username&password=$password&a=1713188925839&producttype=0" -H "Content-Type: application/x-www-form-urlencoded" "$cie_login_url")
	local message=$(echo "$response" | grep -oP '(?<=<message>).*?(?=</message>)')

	# Check for successful login
	if [[ "$message" == *"You are signed in as"* ]]; then
		echo -e "${green}Wi-Fi has been connected successfully.${reset}"
		dunstify -t 3000 "Wi-Fi Connection" "Connected to Wi-Fi successfully!" -u low
		warp-cli connect
		echo -e "${green}Warp has been connected successfully.${reset}"
		dunstify -t 3000 "Warp Connection" "Warp is connected!" -u low
	else
		echo -e "${red}Failed to connect to Wi-Fi.${reset}"
		dunstify -t 3000 "Wi-Fi Connection" "Failed to connect to Wi-Fi." -u critical
	fi
}

# Perform CIE login
cie_login

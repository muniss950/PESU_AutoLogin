#!/bin/bash

IFS=$'\n'

# Define ANSI color codes
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
cyan='\033[0;36m'
reset='\033[0m' # Reset color
if   [[ (! -e ~/.config/pes_login) || "$(cat ~/.config/pes_login)" == "" ]]; then
  touch ~/.config/pes_login 
  echo -n "Enter Your username: "
  read -r username
  echo -n "Enter Your password: "
  read -r password
  echo "$username"
  echo "$password"
  echo $username>>~/.config/pes_login
  echo $password>>~/.config/pes_login
fi

config=$(cat ~/.config/pes_login)
# echo "$config"
read -d EOF -a arr<<< "$config"
# echo "${arr[@]}"
username=$(echo "${arr[0]}") 
password=$(echo "${arr[1]}")
# echo "$username"
# echo "$password"
# Set the URL and password for PES1UG19CS login
pes_login_url="https://192.168.254.1:8090/login.xml"

if command -v warp-cli>/dev/null; then 
warp-cli disconnect >/dev/null
fi
# Function to perform Warp disconnect

# Function to perform CIE login
pes_login() {
    local username="$1"
    local password"$2"
    local response=$(curl -k -s -X POST -d "mode=191&username=$username&password=$2&a=1713188925839&producttype=0" -H "Content-Type: application/x-www-form-urlencoded" "$pes_login_url")
    echo "$response"
    local message=$(echo "$response" | grep -oP '(?<=<message>).*?(?=</message>)')
    echo $message

    if [[ "$message" == "<![CDATA[You are signed in as {username}]]>" ]]; then
        echo -e "${green}Successfully connected to $username${reset}"  # Print the username
        exit 0
    else
        echo -e "${yellow}Trying username $username${reset}"
    fi
}
pes_login $username $password
if command -v warp-cli>/dev/null && [[ $1 == "-w" ]]; then 
  echo "Connecting to warp"
warp-cli connect   >/dev/null 
fi

#!/bin/bash

# Set your username and password here 
username=""
password=""

if [[ -z "$username" || -z "$password" ]]; then
    echo -e "\033[0;31mUsage: $0 <username> <password>\033[0m"
    exit 1
fi

# ===== Define URLs =====
login_url="https://192.168.254.1:8090/login.xml"
logout_url="https://192.168.254.1:8090/logout.xml"

# ===== Colors =====
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
reset='\033[0m'

# ===== Login Function =====
pes_login() {
    local a_param=$(date +%s%3N)

    response=$(curl -k -s -X POST "$login_url" \
        -H 'Content-Type: application/x-www-form-urlencoded' \
        -H 'Origin: https://192.168.254.1:8090' \
        -H 'Referer: https://192.168.254.1:8090/httpclient.html' \
        --data-raw "mode=191&username=$username&password=$password&a=$a_param&producttype=0")

    local message=$(echo "$response" | grep -oP '(?<=<message>).*?(?=</message>)')
    echo $message

    if echo "$message" | grep -qi "signed in"; then
        echo -e "${green}Successfully connected as $username${reset}"
    else
        echo -e "${red}Login failed. Message: $message${reset}"
    fi
}

# ===== Logout Function =====
pes_logout() {
    local a_param=$(date +%s%3N)

    response=$(curl -k -s -X POST "$logout_url" \
        -H 'Content-Type: application/x-www-form-urlencoded' \
        -H 'Origin: https://192.168.254.1:8090' \
        -H 'Referer: https://192.168.254.1:8090/httpclient.html' \
        --data-raw "mode=193&username=$username&a=$a_param&producttype=0")

    local message=$(echo "$response" | grep -oP '(?<=<message>).*?(?=</message>)')
    echo $message

    if echo "$message" | grep -qi "signed out"; then
        echo -e "${green}Successfully logged out $username${reset}"
    else
        echo -e "${red}Logout failed. Message: $message${reset}"
    fi
}

# ===== Call Functions Here =====
# Example:
if [[ $1 == "out" ]] then 
    echo "Loggin out"
    pes_logout
else 
  echo "Logging in"
  pes_login
fi 
# pes_logout

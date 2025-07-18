# AutoLogin Script

This repository contains a script designed for automated login into PES-University WIFI.

## Table of Contents
- [Installation](#installation)

## Installation

1. For bash:
   ```bash
   sudo curl -sL https://github.com/aryan-212/PESU_AutoLogin/raw/main/Login.sh -o /usr/local/bin/pesu && sudo chmod +x /usr/local/bin/pesu
  
2. For windows:
   ```powershell
   git clone https://github.com/aryan-212/PESU_AutoLogin.git
   cd PESU_AutoLogin
   ```
   *[IMPORTANT]* Run this in an elevated Powershell
   ```powershell  
   Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Bypass -Force
   ```

## Usage
1. In linux 
- Setup your profile by entering username and password in the bash code
- Login: 
```bash
   pesu
```
- Logout:
```bash
   pesu out
```
2. In windows:
```powershell
    .\autoLogin.ps1
```

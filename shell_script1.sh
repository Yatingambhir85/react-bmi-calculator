#!/bin/bash

<< TASK
AUTHOR: YATIN GAMBHIR
TASK: DEPLOY A REACT APPLICATION
TASK

RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[34m"
BOLD="\033[1m"
RESET="\033[0m"

code_clone(){
	echo -e "${BOLD}${GREEN}Cloning the code${RESET}\n"
	git clone https://github.com/Yatingambhir85/react-bmi-calculator.git
}

install_requirements(){
	echo "installing dependencies"
	sudo apt-get install docker.io nginx -y
}

required_restarts(){
	sudo systemctl enable docker
	sudo systemctl enable nginx &> /dev/null
	sudo usermod -aG docker $USER
	sudo systemctl restart docker
}

deploy(){

	if [[ $(docker ps -aq -f name=react_bmi_co) ]]; then
		echo "Container 'react_bmi_co' is already exist."
		docker start react_bmi_co
	else
		echo "Creating new container 'react_bmi_co'."
		docker build -t react_bmi:latest .
		docker run -itd -p 3000:3000 --name react_bmi_co react_bmi:latest

	fi
}
cleaning_up(){
	cd ..
	sudo rm -rf react-bmi-calculator
}
echo -e "${RED}---------------------------------\n DEPLOYMENT STARTED \n-------------------------------${RESET}"
if [[ ! -d "react-bmi-calculator/.git" ]]; then
	code_clone
	cd react-bmi-calculator
else
	echo "Directory already present. Skipping Cloning"
fi
if ! command -v docker &> /dev/null || ! command -v nginx &> /dev/null; then
	install_requirements
else
	echo "Docker & Nginx are already installed"
fi
if ! required_restarts; then
	echo "services are up and running no need to restart"
fi
deploy
cleaning_up
echo -e "${RED}-------------------------------------\n DEPLOYMENT COMPLETED \n----------------------${RESET}"

#!/bin/bash

<< TASK
AUTHOR: YATIN GAMBHIR
TASK: DEPLOY A REACT APPLICATION
TASK

code_clone(){
	echo "Cloning the code"
	git clone https://github.com/Yatingambhir85/react-bmi-calculator.git
}

install_requirements(){
	echo "installing dependencies"
	sudo apt-get install docker.io nginx -y
}

required_restarts(){
	sudo systemctl enable docker
	sudo systemctl enable nginx
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
echo -e "---------------------------------\n DEPLOYMENT STARTED \n-------------------------------"
if ! code_clone; then
	echo "the code directory already exists"
	cd react-bmi-calculator
fi
if ! install_requirements; then
	echo "requirements already installed"
	exit 1
fi
if ! required_restarts; then
	echo "services are up and running no need to restart"
fi
deploy
echo -e "-------------------------------------\n DEPLOYMENT COMPLETED \n----------------------"

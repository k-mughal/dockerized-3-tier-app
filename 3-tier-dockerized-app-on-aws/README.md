# 3 Tier dockerized application deployed on AWS
- This project represents a functional demonstration of a three-tier multi-container application deployed on AWS. The Nginx reverse proxy server and the React frontend application are deployed on a public subnet, while the Flask backend service is deployed on a private subnet. Access to the backend service is facilitated through a bastion server, and public access is granted via a NAT gateway. The backend application utilizes an Aurora database. When accessed from an internet browser using the public IP of the public subnet, requests are directed to the Nginx server. The server then communicates with the frontend container, retrieves data from the backend container, and displays it back to the browser.

**Note:** Ensure that you have Docker and Docker-compose installed.

<p align="center">
  <img src="https://github.com/k-mughal/dockerized-3-tier-app/assets/18217530/df205327-17fd-4507-9b4e-28e5b8b4c6cc">
</p>

## How to use:


Clone this repository onto your public subnet EC2 instance and proceed to the folder ‘3-tier-dockerized-app-on-aws’ then  ‘public-subnet’ folder


```
git clone https://github.com/k-mughal/dockerized-3-tier-app.git
```

 In the 'public-subnet' folder execute the following command

```
docker-compose up --build
```

Clone this repository onto your private subnet EC2 instance, ensure NAT Gatway is configured for internet access and navigate to the folder ‘3-tier-dockerized-app-on-aws’ then  ‘private-subnet’ folder

In the 'Private Subnet' folder run the following command

```
docker-compose up --build
```
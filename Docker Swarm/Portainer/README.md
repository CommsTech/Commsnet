Portainer

Change the default app template libary
-------------------------------------
- https://qballjos.github.io/portainer_templates/
>	https://raw.githubusercontent.com/Qballjos/portainer_templates/master/Template/template.json


Update Process
----------------
1. Open your terminal and type
> 	sudo docker ps
![image1](https://user-images.githubusercontent.com/12887622/134815868-6332975d-ffc1-47d3-a1c8-d2e654219b90.JPG)
	1. You'll get a printout like this
![image2](https://user-images.githubusercontent.com/12887622/134815864-870af084-9bcc-447a-831d-e49499391ef3.JPG)
2. Locate the container id for your portainer/portainer-ce:latest and portainer/agent:latest
	- Mine are 7eaa9c543e35, 856e3b5f6ab9, a35b7ea059e6
3. Now youll have to stop and remove the containers using the
> 	sudo docker stop (containerid)
 and
> sudo docker rm (containerid)
![image3](https://user-images.githubusercontent.com/12887622/134815865-be8e8fff-2e60-4a20-badb-43be4326dd70.JPG)
4. Now youll have to do the same thing but with the image this time
> 	sudo docker image ls
![image4](https://user-images.githubusercontent.com/12887622/134815866-dd9d523d-2147-4713-b26f-0ba7a4dfa110.JPG)
5. now ill remove it with the 
> sudo docker image rm (id) --force
6. Finally reinstall with 
> 	sudo docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest


Update 2021
------------
1. Use this one liner for ce
>	sudo docker service update --image portainer/portainer-ce --force portainer_portainer 
2. And this for the agent
>	sudo docker service update --image portainer/agent --force portainer_agent 

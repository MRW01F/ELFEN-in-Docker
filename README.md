# ELFEN-in-Docker

Elfen is using Docker to analyze Malware, with ELFEN-in-Docker we are creating ELFEN inside a docker.
this basically creates the following structure 

`Main Machine-->ELFEN-in-Docker(HostDocker)-->ELFEN(SANDBOX)-->SandboxedContainer(MalwareRunsHere)`

From recursively cloning the main repo `nikhilh-20/ELFEN` there comes a permission error while cloning 
`rsrc/capa` and `rsrc/ELFEN_images`. I have tried saperately cloning both there repo manually to temporarily fix the permission error while cloning.

Read Dockerfile before running Docker build command.
build the image: `docker build -f ./Dockerfile`
interact with container: `docker run -it <container-id> /bin/bash`

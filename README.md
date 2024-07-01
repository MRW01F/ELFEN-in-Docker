# ELFEN-in-Docker

Elfen is using Docker to analyze Malware, with ELFEN-in-Docker we are creating ELFEN inside a docker.
this basically creates the following structure 

`Main Machine-->ELFEN-in-Docker(HostDocker)-->ELFEN(SANDBOX)-->SandboxedContainer(MalwareRunsHere)`

From recursively cloning the main repo `nikhilh-20/ELFEN` there comes a permission error while cloning 
`rsrc/capa` and `rsrc/ELFEN_images`. I have tried saperately cloning both there repo manually to temporarily fix the permission error while cloning.

Read Dockerfile before running Docker build command.
build the image: `docker build -f ./Dockerfile`
interact with container: `docker run -it <container-id> /bin/bash`

there are further optional things you can do to secure the containers for potential side channel attacks in docker.
to harden docker please refer:

[RedHat - Hardening Docker containers, images, and host - security toolkit ](https://www.redhat.com/en/blog/hardening-docker-containers-images-and-host-security-toolkit)

[Docker - Enhanced Container Isolation](https://docs.docker.com/desktop/hardened-desktop/enhanced-container-isolation/)

[OWASP - Docker Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html)

[ResearchGate - Docker container hardening method based on trusted computing](https://www.researchgate.net/publication/344531372_Docker_container_hardening_method_based_on_trusted_computing/link/5f87c52ca6fdccfd7b6265a7/download?_tp=eyJjb250ZXh0Ijp7InBhZ2UiOiJwdWJsaWNhdGlvbiIsInByZXZpb3VzUGFnZSI6bnVsbH19)

curl -L https://downloads.portainer.io/agent-stack.yml -o agent-stack.yml && sudo docker stack deploy --compose-file=agent-stack.yml portainer-agent
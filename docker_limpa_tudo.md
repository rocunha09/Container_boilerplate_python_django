# "Parando todos os containers..."
docker stop $(docker ps -aq) || true

# "Removendo todos os containers..."
docker rm $(docker ps -aq) || true

# "Removendo todos os volumes..."
docker volume rm $(docker volume ls -q) || true

# "Removendo todas as redes (exceto a rede padrão)..."
docker network rm $(docker network ls -q --filter "type=custom") || true

# "Removendo todas as imagens Docker..."
docker rmi -f $(docker images -q) || true

# "Limpando logs gerados pelo Docker..."
sudo rm -rf /var/lib/docker/containers/* || true
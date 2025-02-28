# Variáveis
DOCKERFILE_PATH = infra/dockerfile_backend
IMAGE_NAME = django-dev
CONTAINER_NAME = django-container

# Criar e rodar o container
dev:
	@echo "Criando a imagem Docker..."
	docker build -f $(DOCKERFILE_PATH) -t $(IMAGE_NAME) .
	@echo "Iniciando o container..."
	docker run -dit --name $(CONTAINER_NAME) -p 8000:8000 -v $(shell pwd)/app_backend:/app $(IMAGE_NAME)

# Parar o container
stop:
	@echo "Parando o container..."
	docker stop $(CONTAINER_NAME) || true

# Remover o container
rm:
	@echo "Removendo o container..."
	docker rm $(CONTAINER_NAME) || true

# Parar e remover o container
clean: stop rm
	@echo "Container parado e removido."

# Realizar o clean e também remover a imagem
fclean: clean
	@echo "Removendo a imagem Docker..."
	docker rmi -f $(IMAGE_NAME) || true

# Exibir comandos disponíveis
help:
	@echo "Comandos disponíveis:"
	@echo "  make dev     - Criar e rodar o container"
	@echo "  make stop    - Parar o container"
	@echo "  make rm      - Remover o container"
	@echo "  make clean   - Parar e remover o container"
	@echo "  make fclean  - Parar e remover o container e apagar a imagem"

# Alvo padrão
.DEFAULT_GOAL := help

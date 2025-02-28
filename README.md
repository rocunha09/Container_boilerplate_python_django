# CONTEXTO BASE PARA CRIAR PROJETO DJANGO EM CONTAINER

## Dockerfile
```yaml

# Usa uma imagem oficial do Python
FROM python:3.12

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo de dependências
COPY app_backend/requirements.txt /app/

# Instala dependências (se houver um requirements.txt)
RUN pip install --no-cache-dir -r requirements.txt || true

# Copiar o código do projeto para dentro do container
COPY app_backend /app

# Expõe a porta do Django
EXPOSE 8000

# Mantém o container rodando para acessar em modo interativo e parar o django sem parar o container (facilita o desenvolvimento)
CMD ["tail", "-f", "/dev/null"]

```

## Criando e Executando o Container
```bash
#Criando e rodando o container
docker build -f infra/dockerfile-backend -t django-dev .
docker run -dit --name django-container -p 8000:8000 -v $(pwd)/app_backend:/app django-dev

#parar o container e/ou remover quando quiser
docker stop django-container
docker rm django-container
```

## Acesse o container
```bash
docker exec -it django-container bash
```

## Instale pacotes dentro do container (por exemplo, Django):
```bash
pip install django
pip freeze > requirements.txt
```

## Crie um projeto Django
```bash
django-admin startproject meu_projeto .
```

## Inicie o Django
```bash 
python manage.py runserver 0.0.0.0:8000
```

## Utilize o Makefile para facilitar o desenvolvimento
### Comandos disponíveis:
```Makefile
help:
	@echo "Comandos disponíveis:"
	@echo "  make dev     - Criar e rodar o container"
	@echo "  make stop    - Parar o container"
	@echo "  make rm      - Remover o container"
	@echo "  make clean   - Parar e remover o container"
	@echo "  make fclean  - Parar e remover o container e apagar a imagem"

```
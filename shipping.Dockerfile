# Imagem base derivada do Node
FROM node

# Diretório de trabalho
WORKDIR /app

# Copia todo o conteúdo do projeto para o diretório de trabalho
COPY . /app

# Instala dependências
RUN npm install --production

# Expõe a porta usada pelo serviço de Shipping
EXPOSE 3001

# Inicializa o serviço Shipping
CMD ["node", "/app/services/shipping/index.js"]

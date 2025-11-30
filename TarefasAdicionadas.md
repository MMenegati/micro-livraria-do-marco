## Resumo — Tarefa Prática #1

A Tarefa Prática #1 pede a implementação de uma nova operação no microserviço `Inventory` para pesquisar produtos por ID.

- Arquivos alterados/necessários:
  - `proto/inventory.proto`: adicionar a RPC `SearchProductByID(Payload) returns (ProductResponse)` e a mensagem `Payload { int32 id = 1; }`.
  - `services/inventory/index.js`: implementar o método `SearchProductByID` (usar `call.request.id` para obter o ID e retornar o produto correspondente a partir de `products.json`). Garantir que o nome do método combine exatamente com o definido no `.proto` (ex.: `SearchProductByID`).
  - `services/controller/index.js`: adicionar a rota `GET /product/:id` que chama `inventory.SearchProductByID({ id: Number(req.params.id) }, callback)` e retorna o produto ao cliente.

- Testes rápidos:
  1. Iniciar os serviços (`npm install` e `npm run start`).
  2. Acessar `http://localhost:3000/product/1` ou usar `curl` para verificar que o JSON do produto é retornado.

- Comportamento esperado:
  - Se o produto for encontrado, retorna um objeto `ProductResponse` com os campos `id`, `name`, `quantity`, `price`, `photo` e `author`.
  - Se não for encontrado, pode retornar um objeto vazio ou um 404 (decisão a documentar). A implementação fornecida retorna um objeto vazio para manter compatibilidade com o tipo `ProductResponse`.

- Observações/boas práticas:
  - Manter a correspondência exata (case-sensitive) entre os nomes das RPCs no `.proto` e os métodos registrados no servidor gRPC.
  - Converter `req.params.id` para número antes de enviar ao serviço (`Number(req.params.id)`) já que o campo no `.proto` é `int32`.
  - Atualizar o `README.md` para remover referências a números de linha e padronizar os exemplos (usar `call` no servidor e `request`/obj no cliente).


A Tarefa Prática #3 envolve criar um container Docker para o microserviço `Shipping` e ajustar os scripts de inicialização do projeto para executar o `shipping` via container.

- Arquivos alterados/necessários:
  - `shipping.Dockerfile` (na raiz): instruções para construir a imagem Docker que roda `services/shipping/index.js` na porta `3001`.
  - `package.json`: remover `start-shipping` do script `start` para evitar iniciar o serviço localmente quando for executado via container.

- Passos principais executados:
  1. Verifiquei/criei `shipping.Dockerfile` com as instruções `FROM node`, `WORKDIR /app`, `COPY . /app`, `RUN npm install --production`, `EXPOSE 3001` e `CMD ["node","/app/services/shipping/index.js"]`.
  2. Atualizei `package.json` para que `npm run start` não inclua mais `start-shipping`.

- Testes rápidos recomendados:
  - Construir a imagem Docker:
    ```powershell
    docker build -t micro-livraria/shipping -f shipping.Dockerfile ./
    ```
  - Executar o container:
    ```powershell
    docker run -ti --name shipping -p 3001:3001 micro-livraria/shipping
    ```
  - Iniciar os demais serviços localmente (agora sem shipping no `start`):
    ```powershell
    npm install
    npm run start
    ```

- Observações / melhorias sugeridas:
  - Adicionar um arquivo `.dockerignore` para evitar copiar `node_modules`, logs e arquivos desnecessários para a imagem.
  - Para imagens menores, usar multi-stage builds (instalar dependências em etapa de build e copiar apenas o resultado) ou uma imagem `node:alpine` se compatível.
  - Decidir e documentar no `README.md` quando usar container (produção/testes) e quando rodar localmente com `nodemon`.

Resumo criado automaticamente pelo assistente.

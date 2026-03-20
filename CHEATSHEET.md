# Docker Cheat Sheet (estudos iniciais)

Guia rapido para memorizar os comandos que voce ja praticou.

## `docker ps` vs `docker ps -a`

- `docker ps`
  - Mostra somente containers em execucao (status `Up`).
- `docker ps -a`
  - Mostra todos: rodando, parados (`Exited`) e criados.

Atalho mental:
- `ps` = "o que esta vivo agora"
- `ps -a` = "historico completo de containers"

## `docker image ls` e `docker tag`

- `docker image ls`
  - Lista imagens locais (repositorio, tag, id, tamanho).
  - Equivalente curto: `docker images`.

Exemplo:

`docker image ls`

- `docker tag ORIGEM NOVO_NOME`
  - Cria uma nova tag para a mesma imagem (nao duplica conteudo).
  - Muito usado para versionar (`:v1`, `:latest`) e preparar push.

Exemplos:

`docker tag api api:v1`
`docker tag api:v1 meuusuario/api:v1`

Atalho mental:
- `image ls` = "quais imagens eu tenho"
- `tag` = "apelido/versionamento da mesma imagem"

## Regra de ouro: ordem do `docker run`

Formato:

`docker run [OPCOES] IMAGEM [COMANDO]`

Exemplo correto:

`docker run --name rocketseat -p 3333:3333 -d api`

Se voce colocar `--name` depois da imagem, vira argumento do comando interno e pode falhar.

---

## Portas (o que vai no browser vs container)

Formato:

`-p HOST:CONTAINER`

- Esquerda (`HOST`): porta do seu PC (browser acessa aqui)
- Direita (`CONTAINER`): porta em que a app escuta dentro do container

Exemplo:

`docker run -p 3001:3333 api`

- Browser: `http://localhost:3001`
- App no container: `3333`

Se a app escuta em `3333`, usar `-p 3333:3001` vai dar ruim.

---

## Fluxo mental: `run`, `start`, `stop`, `rm`

- `docker run ...`
  - Cria um container novo e inicia.
- `docker stop <nome|id>`
  - Para o container.
  - Libera a porta.
  - NAO remove o container.
  - NAO libera o nome.
- `docker start <nome|id>`
  - Inicia novamente um container ja existente/parado.
- `docker rm <nome|id>`
  - Remove container parado.
- `docker rm -f <nome|id>`
  - Forca parada e remove.

---

## `Ctrl + C` vs `-d`

- Sem `-d` (foreground):
  - `Ctrl + C` tenta parar o processo.
  - Em alguns casos (como seu setup com Bun), pode demorar.
- Com `-d` (detached):
  - Container roda em background.
  - `Ctrl + C` nao para o container.
  - Para com `docker stop <nome|id>`.

---

## Nomes aleatorios (por que aparecem)

Se voce nao usar `--name`, Docker cria nomes aleatorios:

- `happy_kepler`
- `gracious_faraday`
- etc.

Para evitar:

`docker run --name rocketseat ...`

---

## Comandos base para o seu projeto

### Build da imagem

`docker build -t api .`

- `-t api`: da nome/tag para a imagem
- `.`: contexto do build (pasta atual)

### Rodar em foreground

`docker run --name rocketseat -p 3333:3333 api`

### Rodar em background

`docker run --name rocketseat -p 3333:3333 -d api`

### Ver containers rodando

`docker ps`

### Ver todos (inclusive parados)

`docker ps -a`

### Ver logs

`docker logs rocketseat`

Logs em tempo real:

`docker logs -f rocketseat`

### Parar

`docker stop rocketseat`

### Iniciar de novo sem criar outro

`docker start rocketseat`

### Remover

`docker rm rocketseat`

---

## Erros comuns e causa

### `port is already allocated`

Causa:
- porta ja esta ocupada por outro container/processo

Resolver:
- parar o que esta usando a porta, ou
- usar outra porta no host (`-p 3001:3333`)

### `container name is already in use`

Causa:
- voce deu `stop`, mas nao removeu

Resolver:
- `docker start <nome>` para reutilizar, ou
- `docker rm <nome>` para criar outro com mesmo nome

---

## Dicas para nao se confundir

- Sempre use `--name` (ex.: `rocketseat`).
- Para estudo, prefira:
  - `docker run --name rocketseat --rm -p 3333:3333 -d api`
- Use sempre a regra:
  - `run [opcoes] imagem`
- Pense em portas como:
  - "browser na esquerda, app na direita"

---

## Mini roteiro de estudo (repeticao)

1. `docker build -t api .`
2. `docker run --name rocketseat -p 3333:3333 -d api`
3. Testar no browser
4. `docker logs -f rocketseat`
5. `docker stop rocketseat`
6. `docker start rocketseat`
7. `docker stop rocketseat && docker rm rocketseat`


# Guia de Servidores Dedicados | Don't Starve Together

Esse é um guia para criar servidores dedicados de Don't Starve Together em Linux utilizando bash.

### Instalação

Antes de começar a instalação certifique-se que você tem os seguintes pré-requisitos instalados:
* SteamCMD
* Algumas Libs:
No Ubuntu:
    `sudo apt-get install libstdc++6:i386 libgcc1:i386 libcurl4-gnutls-dev:i386`

No Arch:
    `sudo pacman -S libcurl-gnutls`

### Criação do servidor

Entre no site https://accounts.klei.com/ e faça o login na sua conta. Após isso vá na aba "JOGOS" e selecione a opção "SERVIDORES" logo abaixo de Don't Starve Together. Agora defina o nome do seu servidor, aqui vamos usar "exemplo-servidor" no nome, e clique em "ADICIONAR NOVO SERVIDOR". Agora com seu servidor criado, clique em "CONFIGURAR SERVIDOR" e deixe as configurações conforme sua preferência.
Depois de configurar o servidor clique em "CONFIGURAÇÕES DE DOWNLOAD" e baixe o arquivo "MyDediServer.zip"

### Configurando o servidor

Copie o arquivo "MyDediServer.zip" e cole na pasta ~/.klei/DoNotStarveTogether. Após isso extraia o arquivo.
Isso gerará uma pasta chamada "MyDediServer". Entre nessa pasta e crie uma pasta chamada "mods" (ela vai ser muito útil futuramente). 

#### Entendendo os arquivos
Essa pasta (MyDediServer) é o Cluster do seu servidor, ou seja o coração de seu mundo, é aqui que estarão os arquivos essenciais do servidor.

```
    /Caves          ---> Essa é a pasta que guarda todo shard de cavernas do seu servidor
    /Master         ---> Essa é a pasta que guarda todo shard da superfície do seu servidor
    /mods           ---> Essa é a pasta que guarda as configurações dos mods do seu servidor
    cluster.ini     ---> Esse é o arquivo de configuração do seu servidor (não modifique ao menos que você saiba o que está fazendo)
    cluster.token   ---> Esse é o arquivo de token do seu servidor (não modifique ao menos que você saiba o que está fazendo)
```

### Iniciando o servidor
Para iniciar o servidor, certifique-se que o arquivo "start-server.sh" tem permissões de executar como um programa, caso tenha basta executar no terminal:
`~/dst-dedi-sv.sh`



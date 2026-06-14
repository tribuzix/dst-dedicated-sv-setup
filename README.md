# Guia de Servidores Dedicados | Don't Starve Together
Esse é um guia para criar servidores dedicados de Don't Starve Together em Linux utilizando bash.

## Instalação
Antes de começar a instalação certifique-se que você tem os seguintes pré-requisitos instalados:
* [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD)
* Algumas Libs:

    No Ubuntu:
    
    `sudo apt-get install libstdc++6:i386 libgcc1:i386 libcurl4-gnutls-dev:i386`

    No Arch:
    
    `sudo pacman -S libcurl-gnutls`
* Git:

    No Ubuntu:
    
    `sudo apt-get install git`
    
    No Arch:
    
    `sudo pacman -S git`
* Este repositório

    Para isso, execute: `git clone https://github.com/tribuzix/dst-dedicated-sv-setup.git`

### Criação do servidor
Entre no site [Klei Accounts](https://accounts.klei.com/) e faça o login na sua conta.

Após isso vá na aba "JOGOS" e selecione a opção "SERVIDORES" logo abaixo de Don't Starve Together.

Defina o nome do seu servidor, aqui vamos usar "exemplo-servidor" no nome, e clique em "ADICIONAR NOVO SERVIDOR".

Com seu servidor criado, clique em "CONFIGURAR SERVIDOR" e deixe as configurações conforme sua preferência.

Depois de configurar o servidor clique em "CONFIGURAÇÕES DE DOWNLOAD" e baixe o arquivo "MyDediServer.zip"

### Configurando o servidor
Copie o arquivo "MyDediServer.zip", cole na pasta ~/.klei/DoNotStarveTogether e extraia.

Isso gerará uma pasta chamada "MyDediServer".

Entre nessa pasta e crie uma pasta chamada "mods" (ela vai ser muito útil futuramente.

### Entendendo os arquivos
Essa pasta (MyDediServer) é o Cluster do seu servidor, ou seja o coração de seu mundo, é aqui que estarão os arquivos essenciais do servidor.

```
    /Caves              ---> Essa é a pasta que guarda todo shard de cavernas do seu servidor
    /Master             ---> Essa é a pasta que guarda todo shard da superfície do seu servidor
    /mods               ---> Essa é a pasta que guarda as configurações dos mods do seu servidor
        cluster.ini     ---> Esse é o arquivo de configuração do seu servidor (não modifique ao menos que você saiba o que está fazendo)
        cluster.token   ---> Esse é o arquivo de token do seu servidor (não modifique ao menos que você saiba o que está fazendo)
```

### Iniciando o servidor
Para iniciar o servidor, certifique-se que o arquivo "start-server.sh" tem permissões de executar como um programa.

Inicie o servidor executando no terminal:

```~/start-server.sh```

## Instalando Mods
Dentro da pasta mods você encontrará dois arquivos (se não localizá-los, crie-os).

```
    dedicated_server_mods_setup.lua     ---> Este é o arquivo responsável por baixar os mods que estarão disponíveis para o seu servidor
    modoverrides.lua                    ---> Este é o arquivo responsável por ativar e configurar 
```
Caso você já saiba configurar mods em servidores dedicados, saiba que esses são os únicos arquivos nos quais você precisará se preocupar, o restante será executado pelo script. Caso você não saiba, continue com o guia.

### Baixando Mods
A primeira etapa para instalar os mods é editar o arquivo `dedicated_server_mods_setup.lua`. Ele possui uma estrutura simples, tudo que você precisa fazer é chamar a função "ServerModSetup" e definir o parâmetro relativo ao seu mod (para descobrir o número do seu mod, basta acessar seu link na steam e copiar os últimos números do link).

##### Para exemplificar:
Caso eu queira instalar o mod cujo o link é: https://steamcommunity.com/sharedfiles/filedetails/?id=378160973

Basta pegar o ID do final do mod, que nesse caso é: "378160973"

Então no arquivo `dedicated_server_mods_setup.lua` o texto ficará assim:

`ServerModSetup("378160973")`

Você deverá repetir esse processo para todos os mods que você quiser deixar disponíveis para serem ativados no seu servidor.

### Ativando Mods
A segunda etapa para instalar os mods é editar o arquivo `modoverrides.lua`. O arquivo é estruturado da seguinte forma:

```
    return {
  ["workshop-ex1"]={ configuration_options={  }, enabled=true },
  ["workshop-ex2"]={ configuration_options={  }, enabled=true },
  ["workshop-ex3"]={ configuration_options={  }, enabled=true },
}
```

#### Método Manual
Esse método é feito para pessoas que estão mais acostumadas a editar arquivos de configuração e não se importam em aprender sobre, caso você seja um usuário mais leigo, pule para a seção de "Método Intuitivo".

Para definir os mods que você deseja ativar basta substituir "ex1" pelo id do seu primeiro mod, "ex2" pelo id do seu segundo mod e assim por diante (repita quantas vezes for necessário). 

###### Para exemplificar:
Caso eu queira ativar o mod cujo o link é: https://steamcommunity.com/sharedfiles/filedetails/?id=378160973

Basta pegar o ID do final do mod, que nesse caso é: "378160973"

Então no arquivo `modoverrides.lua` o texto ficará assim:

```
    return {
  ["workshop-378160973"]={ configuration_options={  }, enabled=true },
}
```

Caso eu queira ativar diversos mods, basta repetir esse processo, copiando a linha 2 e colando em uma nova linha, apenas substituindo o ID do mod.

#### Método Intuitivo
Esse método é feito para pessoas mais leigas que não querem lidar com arquivos de configurações, querem apenas configurar seus mods assim como no jogo normal e iniciar seu servidor.

Para definir os mods que você deseja ativar basta iniciar o jogo Don't Starve Together, ir em "Host Game" e depois em "Create New World".

Crie seu mundo com as configurações que você deseja e com o "Save Type" definido em "Local Save"", ative os mods (lembre-se que eles precisam antes estar presentes em `dedicated_server_mods_setup.lua`) e configure-os da maneira que desejar. Inicie o mundo, escolha um personagem, e saia do mundo.

No menu principal selecione "Host Game", e no mundo que você criou selecione a opção "Manage World". O jogo te mostrará onde estão salvos os arquivos através da seguinte mensagem:

```
Local world files are available at:
SAVEDATA:/Cluster_1
```

Anote o número do Cluster do seu mundo, vá até `~/.klei/DoNotStarveTogether` entre na pasta nomeada apenas com números e procure o Cluster idêntico ao do seu mundo.

Ao acessá-lo vá até o diretório "Master" e copie o arquivo `modoverrides.lua` e depois cole-o em `~/.klei/DoNotStarveTogether/MyDediServer/mods`

###### Opcional

Caso queira também copiar as configurações do seu mundo criado para o seu servidor dedicado, basta voltar ao diretório do Cluster do seu mundo, entrar em "Master" e copiar o arquivo `leveldataoverride.lua` e colar em `~/.klei/DoNotStarveTogether/MyDediServer/Master`. Para copiar as configurações das cavernas basta realizar o mesmo processo, mas copiando o `leveldataoverride.lua` do diretório "Caves" do Cluster do seu mundo, e colando em `~/.klei/DoNotStarveTogether/MyDediServer/Caves`

# Documentação para Configuração do Ambiente de Desenvolvimento com Docker, VS Code, PHP, PostgreSQL e Nginx no Linux
Esta documentação descreve como configurar um ambiente de desenvolvimento web utilizando Docker Compose, VS Code, PHP, PostgreSQL e Nginx. 
O Nginx será utilizado como um servidor web e substituto do Apache. Lembrando que esse projeto foi efetuado no Debian GNU/Linux 12 (bookworm).

## Pré-requisitos
 - Docker: Instale o Docker seguindo as instruções no [site oficial](https://docs.docker.com/get-docker/).
 - Docker Compose: Instale o Docker Compose seguindo as instruções no [site oficial](https://docs.docker.com/compose/install/).
 - VS Code: Instale o Visual Studio Code seguindo as instruções no [site oficial](https://code.visualstudio.com/).

## Passo a Passo para Configuração
1. Criação do Projeto e Estrutura de Pastas
Crie um diretório para o seu projeto e configure a seguinte estrutura de pastas:

```
project-root/
├── docker-compose.yml
├── Dockerfile
├── nginx/
│   └── default.conf
├── src/
│   └── index.php
└── config/
│   └── php/
│      └── conf.d/
│          └── xdebug.ini
```

2. Arquivo docker-compose.yml
Crie o arquivo docker-compose.yml conforme file do projeto.

4. Arquivo Dockerfile
Crie o arquivo Dockerfile conforme file do projeto.

5. Instalar Xdebug para adicionar o trecho seguinte ao Dockerfile conforme projeto:

```
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

## Copiar configurações personalizadas do PHP
COPY ./config/php/conf.d /usr/local/etc/php/conf.d
```

6. Configuração do Nginx
Crie o arquivo nginx/default.conf com as configurações conforme file do projeto.

7. Arquivo index.php para Teste
Crie um arquivo src/index.php com o trecho php básico (phpinfo) conforme estrutura do projeto.

8. Construir e Iniciar os Contêineres
No terminal, navegue até o diretório do projeto e execute os seguintes comandos:

```
docker-compose down
docker-compose up -d --build
```

10. Verificar no Navegador
Abra o seu navegador e acesse http://localhost:8080. Você deve ver a página de informações do PHP.

## Resolução de Problemas Adicionais
Permissões de Acesso ao Docker Socket
Se encontrar problemas de permissão com o Docker, adicione seu usuário ao grupo docker:

```
sudo usermod -aG docker $USER
newgrp docker
```

## Configuração do Nginx como Proxy Reverso
De acordo com a documentação da [Microsoft](https://learn.microsoft.com/pt-br/troubleshoot/developer/webapps/aspnetcore/practice-troubleshoot-linux/2-2-install-nginx-configure-it-reverse-proxy),
para configurar o Nginx como um proxy reverso, edite o arquivo /etc/nginx/sites-enabled/default com a seguinte configuração:

```
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Substitua http://localhost:5000 pelo endereço e porta apropriados do seu backend PHP.

## Conclusão
Seguindo estas etapas, você terá um ambiente de desenvolvimento web configurado com Docker, Nginx, PHP e PostgreSQL,
pronto para uso com o Visual Studio Code. Se houver problemas adicionais ou necessidades específicas, sinta-se à vontade para ajustar a configuração conforme necessário.

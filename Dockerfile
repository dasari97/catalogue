## During Docker Build
FROM            node
RUN             useradd -m -d /app roboshop
USER            roboshop
WORKDIR         /app
COPY            server.js .
COPY            package.json .
RUN             npm install

# During ContAiner Launch
ENTRYPOINT     ["node"]
CMD            ["server.js"]

# node server.js
## Entrypoint is command, CMD is argument
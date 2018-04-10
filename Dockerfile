FROM node:slim

WORKDIR /app
ADD . /app

RUN apt-get update && \
    apt-get install -y ruby && \
    apt-get clean && \
    yarn install

VOLUME content
VOLUME dist

CMD ruby menugen.rb && yarn run build && cp -r css/ bundle.js index.html dist/

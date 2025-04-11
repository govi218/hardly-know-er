FROM node:20

WORKDIR /app

RUN apt-get update && \
    apt-get install -y sqlite3 python3 build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml* ./

RUN yes | pnpm install --force --no-optional

COPY . .

RUN cd node_modules/better-sqlite3 && \
    npm run build-release && \
    cd ../..

EXPOSE 3000

ENV NODE_ENV production

CMD ["pnpm", "start"]

FROM node:18

WORKDIR /app

# dependencies

RUN apt-get update \
    && apt-get install -y --no-install-recommends lua5.1 \
    && rm -rf /var/lib/apt/lists/*

COPY package.json ./
COPY package-lock.json ./

RUN npm ci

# project code

COPY src/ src/
COPY tools/ tools/
COPY rollup.config.ts ./
COPY tsconfig.json ./

RUN npm run build

CMD ["npm", "run", "host"]

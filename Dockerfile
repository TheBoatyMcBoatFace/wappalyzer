FROM node:14-alpine

MAINTAINER Wappalyzer <hello@wappalyzer.com>

ENV WAPPALYZER_ROOT /opt/wappalyzer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV CHROMIUM_BIN /usr/bin/chromium-browser

RUN apk update && apk add -u --no-cache \
  nodejs \
  udev \
  chromium \
  ttf-freefont \
  yarn

RUN mkdir -p "$WAPPALYZER_ROOT/browsers"

WORKDIR "$WAPPALYZER_ROOT"

COPY technologies ./src/technologies
COPY \
  ./src/drivers/npm/cli.js \
  ./src/categories.json \
  ./src/drivers/npm/driver.js \
  ./src/package.json \
  ./src/wappalyzer.js \
  yarn.lock ./

RUN yarn install

ENTRYPOINT ["node", "cli.js"]

FROM node:16.4.1-alpine

# 任意のtime zone設定にする
ENV TZ=Asia/Tokyo
RUN apk --no-cache add tzdata && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR ./

COPY package.json .
COPY yarn.lock .
COPY prisma ./prisma
RUN yarn install
RUN npx prisma generate


EXPOSE 5000

ENTRYPOINT [ "yarn", "start:dev" ]
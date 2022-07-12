FROM node:16-buster-slim as build

WORKDIR /usr/src/app

COPY ./nosgestesclimat ./nosgestesclimat
COPY ./nosgestesclimat-site ./nosgestesclimat-site
WORKDIR /usr/src/app/nosgestesclimat-site

RUN yarn
RUN yarn compile

FROM nginx:alpine as prod

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/nosgestesclimat-site/dist/ /usr/share/nginx/html
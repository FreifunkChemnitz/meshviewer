FROM node:latest AS build

COPY . /app
WORKDIR /app
RUN npm install
RUN npm run build


FROM nginx:alpine AS www

COPY --from=build /app/build /usr/share/nginx/html
# Add robots.txt
ADD ./robots.txt /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
EXPOSE 80
# nginx gets automatically started as user nginx, no USER required

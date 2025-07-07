#Build Stage
From node: lts-alpine AS Build
WORKDIR /app
COPY package*.json ./

RUN npm install
COPY . .
RUN npm run build

#Production Stage
FROM nginx:stable-alpine AS Production
COPY --from=Build /app/dist /usr/share/nginx/html
COPY --from=Build /app/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
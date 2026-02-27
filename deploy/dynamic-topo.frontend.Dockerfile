FROM node:20-alpine AS build
WORKDIR /app

COPY components/dynamic-topo/frontend/package*.json ./
RUN npm ci

COPY components/dynamic-topo/frontend/ ./
RUN npm run build

FROM nginx:1.27-alpine
COPY components/dynamic-topo/frontend/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

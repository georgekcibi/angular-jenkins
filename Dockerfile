FROM node:14.21.3 AS builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build


FROM httpd:2.4-alpine
EXPOSE 80
WORKDIR /usr/local/apache2/htdocs
RUN rm -rf *
COPY --from=builder /app/dist/keyshell/* /usr/local/apache2/htdocs/
CMD ["httpd-foreground"]

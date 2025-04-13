FROM gradle:7.6.1-jdk11

WORKDIR /app

COPY . .

EXPOSE 8080

CMD gradle apprun 

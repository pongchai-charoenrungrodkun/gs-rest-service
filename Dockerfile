FROM openjdk:17
LABEL maintainer="pongchai.mobile@gmail.com"
ARG JAR_FILE=complete/target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
EXPOSE 8080

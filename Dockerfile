FROM jenkins/jenkins:lts
USER root
RUN apt-get update
RUN curl -sSL https://get.docker.com/ | sh

FROM openjdk:11.0.10-jre-slim
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} /sg-configserver.jar
ENTRYPOINT ["java","-jar","/sg-configserver.jar"]
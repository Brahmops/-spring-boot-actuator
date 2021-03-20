FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD

MAINTAINER Sarath 

COPY pom.xml /build/
COPY src /build/src/

WORKDIR /build/
RUN mvn package
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/spring-boot-actuator-0.0.1-SNAPSHOT.jar /app/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-boot-actuator-0.0.1-SNAPSHOT.jar"]




#WORKDIR /app
#COPY --from=MAVEN_BUILD /build/target/myproject-0.0.1-SNAPSHOT.jar /app/
#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "myproject-0.0.1-SNAPSHOT.jar"]

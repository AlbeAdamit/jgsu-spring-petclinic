FROM maven:3.5.4-jdk-8-alpine as maven

WORKDIR /new-one

COPY pom.xml ./

COPY . ./

RUN mvn dependency:go-offline

RUN mvn spring-javaformat:help

RUN mvn spring-javaformat:apply

RUN mvn package

FROM openjdk:8u171-jre-alpine

COPY --from=maven /new-one/target/spring-petclinic-*.jar ./spring-petclinic.jar

CMD ["java", "-jar", "./spring-petclinic.jar -Dspring-boot.run.profiles=mysql"]

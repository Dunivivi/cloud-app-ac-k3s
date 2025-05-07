# Build
FROM gradle:8.7-jdk17 AS build

COPY --chown=gradle:gradle . /home/gradle/project
WORKDIR /home/gradle/project

RUN gradle bootJar --no-daemon

# Run app
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

COPY --from=build /home/gradle/project/build/libs/cloud-app-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

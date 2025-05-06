# Build
FROM gradle:8.7-jdk17 AS build

# Copy gradle in container
COPY --chown=gradle:gradle . /home/gradle/project
WORKDIR /home/gradle/project

# Prepare jar file
RUN gradle bootJar --no-daemon

# Run app
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

COPY build/libs/cloud-app-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]

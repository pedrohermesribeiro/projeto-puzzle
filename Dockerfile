# Etapa 1: Construção
FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
# Copy frontend files to static directory
RUN mkdir -p src/main/resources/static
RUN cp -r puzzle.html puzzle.js style.css images src/main/resources/static
RUN mvn clean install -DskipTests

# Etapa 2: Execução
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /app/target/puzzle-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
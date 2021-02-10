# Chatter

* Chat application supporting multiple concurrent users leveraging gRPC with Protocol Buffers in Python and Dart
* Microservice architecture with Docker and Docker-Compose to improve maintainability and scalability

## Requirements

1. gRPC
2. Flutter
3. Docker
4. Docker Compose
5. (Optional) protoc

## Steps

0. Make sure that all the requirements are met before starting!

   - Run `flutter --version` to check if you have Flutter.

   - Run `docker info` to check if the Docker is running on the system.

1. (Optional) Run : `sh generateGrpcStubs.sh`

   - Generates the GRPC stubs for both the Python backend and the Flutter frontend

2. Run : `docker-compose build`

   - Builds docker containers for both the server and the database.

3. Run : `docker-compose up -d`

   - Runs both of the containers in the background (detached mode).

4. Run : `sh setupFlutterEnvironment.sh`

   - Downloads and installs all required packages from pubspec.yaml

5. Run : `sh startClient.sh`

   - Opens an iOS Simulator

     - If iOS simulator is not available, please start an Android client and run : `cd client && flutter run`

   - Starts the client which can communicate with the server

     - Error handling is provided in case of no internet connection

6. Run : `docker-compose down`

   - Shuts down the docker contains for both the server and the database.

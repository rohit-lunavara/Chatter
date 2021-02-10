#!/bin/sh

python -m grpc_tools.protoc -I protos/ --python_out=backend/server/ --grpc_python_out=backend/server/ protos/chatApplication.proto
pub global activate protoc_plugin && protoc --dart_out=grpc:client/lib/src/generated -I protos protos/chatApplication.proto

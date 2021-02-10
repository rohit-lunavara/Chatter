from app.chatApplicationDatabase.chatApplicationModel import ChatApplicationModel
from chatApplicationServicer import ChatApplicationServicer
from concurrent import futures
import grpc
import time
import logging
import json
import os
from config import config


def serve():
    # Read in key and certificate
    # basedir = os.path.abspath(os.path.dirname(__file__))
    # with open(os.path.join(basedir, 'security', 'server.key'), 'rb') as f:
    #     privateKey = f.read()
    # with open(os.path.join(basedir, 'security', 'server.crt'), 'rb') as f:
    #     certificateChain = f.read()

    # Create server credentials
    # serverCredentials = grpc.ssl_server_credentials(((privateKey, certificateChain),))

    # Initialize GRPC Server
    grpcServer = grpc.server(futures.ThreadPoolExecutor(max_workers=10))

    # Initialize Services - GRPC servicers with reference to GRPC Server and appropriate service reference
    devConfig = config["current"]
    ChatApplicationServicer(grpcServer, ChatApplicationModel(devConfig))

    # Start GRPC server on secure port using credentials
    # grpcServer.add_secure_port('localhost:50101', serverCredentials)
    grpcServer.add_insecure_port("[::]:50101")
    grpcServer.start()
    grpcServer.wait_for_termination()


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    logging.getLogger('log').setLevel(logging.ERROR)
    serve()

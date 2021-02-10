import grpc
from chatApplication_pb2 import UserRequest, CreateUserResponse, VerifyCredentialsResponse, CreateMessageRequest, CreateMessageResponse, MessageResponse
from chatApplication_pb2_grpc import ChatApplicationStub
import os

# Read in certificate
basedir = os.path.abspath(os.path.curdir)
with open(os.path.join(basedir, 'security', 'server.crt'), 'rb') as f:
    trustedCerts = f.read()

# Create credentials
credentials = grpc.ssl_channel_credentials(root_certificates=trustedCerts)

# Create channel using ssl credentials
# channel = grpc.insecure_channel("[::]:50101")
channel = grpc.secure_channel("localhost:50101", credentials)

stub = ChatApplicationStub(channel)

user = UserRequest(email="rohit.lunavara@gmail.com", password="reset123")
message = CreateMessageRequest(user=user, message="Test Message")

stub.CreateUser(user)
stub.CreateMessage(message)
for message in stub.GetMessages(user):
    print(message)

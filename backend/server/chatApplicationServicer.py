from chatApplication_pb2_grpc import ChatApplicationServicer, add_ChatApplicationServicer_to_server
from chatApplication_pb2 import UserRequest, CreateUserResponse, VerifyCredentialsResponse, CreateMessageRequest, CreateMessageResponse, MessageResponse
from google.protobuf.timestamp_pb2 import Timestamp
import logging


class ChatApplicationServicer(ChatApplicationServicer):
    """Provides methods that implement functionality of the Chat Application Service."""

    def __init__(self, grpcServer, chatApplicationModel):
        """Binds to a server and the Chat Application data model
        """
        logging.debug("ChatApplicationServicer started")

        self.chatApplicationModel = chatApplicationModel
        add_ChatApplicationServicer_to_server(self, grpcServer)

    def CreateUser(self, request, context):
        """Creates a new user
        """
        logging.debug(">>> ChatApplicationServiceServicer:CreateUser: ")
        logging.debug(request)

        isUserCreated = self.chatApplicationModel.createUser(
            request.email, request.password)
        return CreateUserResponse(isCreated=isUserCreated)

    def VerifyCredentials(self, request, context):
        """Verify a user's username and password
        """
        logging.debug(">>> ChatApplicationServiceServicer:VerifyCredentials: ")
        logging.debug(request)
        isUserValid = self.chatApplicationModel.verifyCredentials(
            request.email, request.password)
        return VerifyCredentialsResponse(isValid=isUserValid)

    def CreateMessage(self, request, context):
        """Creates a message if the user is verified
        """
        logging.debug(">>> ChatApplicationServiceServicer:CreateMessage: ")
        logging.debug(request)
        isMessageCreated = self.chatApplicationModel.createMessage(
            request.user.email, request.user.password, request.message)
        return CreateMessageResponse(isCreated=isMessageCreated)

    def GetMessages(self, request, context):
        """Returns all messages as a stream
        """
        logging.debug(">>> ChatApplicationServiceServicer:GetMessages: ")
        logging.debug(request)
        for message in self.chatApplicationModel.getMessages(request.email, request.password):
            messageResponse = MessageResponse(
                email=message.email, message=message.message)
            logging.debug(messageResponse)
            yield messageResponse

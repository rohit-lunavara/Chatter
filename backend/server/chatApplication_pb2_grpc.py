# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import chatApplication_pb2 as chatApplication__pb2


class ChatApplicationStub(object):
    """import "google/protobuf/timestamp.proto";

    The service responsible for managing user information
    """

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.CreateUser = channel.unary_unary(
                '/chatApp.ChatApplication/CreateUser',
                request_serializer=chatApplication__pb2.UserRequest.SerializeToString,
                response_deserializer=chatApplication__pb2.CreateUserResponse.FromString,
                )
        self.VerifyCredentials = channel.unary_unary(
                '/chatApp.ChatApplication/VerifyCredentials',
                request_serializer=chatApplication__pb2.UserRequest.SerializeToString,
                response_deserializer=chatApplication__pb2.VerifyCredentialsResponse.FromString,
                )
        self.CreateMessage = channel.unary_unary(
                '/chatApp.ChatApplication/CreateMessage',
                request_serializer=chatApplication__pb2.CreateMessageRequest.SerializeToString,
                response_deserializer=chatApplication__pb2.CreateMessageResponse.FromString,
                )
        self.GetMessages = channel.unary_stream(
                '/chatApp.ChatApplication/GetMessages',
                request_serializer=chatApplication__pb2.UserRequest.SerializeToString,
                response_deserializer=chatApplication__pb2.MessageResponse.FromString,
                )


class ChatApplicationServicer(object):
    """import "google/protobuf/timestamp.proto";

    The service responsible for managing user information
    """

    def CreateUser(self, request, context):
        """Creates a new user
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def VerifyCredentials(self, request, context):
        """Verify a user's username and password
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def CreateMessage(self, request, context):
        """Creates a message
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetMessages(self, request, context):
        """Retrieves messages
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_ChatApplicationServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'CreateUser': grpc.unary_unary_rpc_method_handler(
                    servicer.CreateUser,
                    request_deserializer=chatApplication__pb2.UserRequest.FromString,
                    response_serializer=chatApplication__pb2.CreateUserResponse.SerializeToString,
            ),
            'VerifyCredentials': grpc.unary_unary_rpc_method_handler(
                    servicer.VerifyCredentials,
                    request_deserializer=chatApplication__pb2.UserRequest.FromString,
                    response_serializer=chatApplication__pb2.VerifyCredentialsResponse.SerializeToString,
            ),
            'CreateMessage': grpc.unary_unary_rpc_method_handler(
                    servicer.CreateMessage,
                    request_deserializer=chatApplication__pb2.CreateMessageRequest.FromString,
                    response_serializer=chatApplication__pb2.CreateMessageResponse.SerializeToString,
            ),
            'GetMessages': grpc.unary_stream_rpc_method_handler(
                    servicer.GetMessages,
                    request_deserializer=chatApplication__pb2.UserRequest.FromString,
                    response_serializer=chatApplication__pb2.MessageResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'chatApp.ChatApplication', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class ChatApplication(object):
    """import "google/protobuf/timestamp.proto";

    The service responsible for managing user information
    """

    @staticmethod
    def CreateUser(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/chatApp.ChatApplication/CreateUser',
            chatApplication__pb2.UserRequest.SerializeToString,
            chatApplication__pb2.CreateUserResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def VerifyCredentials(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/chatApp.ChatApplication/VerifyCredentials',
            chatApplication__pb2.UserRequest.SerializeToString,
            chatApplication__pb2.VerifyCredentialsResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def CreateMessage(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/chatApp.ChatApplication/CreateMessage',
            chatApplication__pb2.CreateMessageRequest.SerializeToString,
            chatApplication__pb2.CreateMessageResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetMessages(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_stream(request, target, '/chatApp.ChatApplication/GetMessages',
            chatApplication__pb2.UserRequest.SerializeToString,
            chatApplication__pb2.MessageResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

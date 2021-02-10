///
//  Generated code. Do not modify.
//  source: chatApplication.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'chatApplication.pb.dart' as $0;
export 'chatApplication.pb.dart';

class ChatApplicationClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$0.UserRequest, $0.CreateUserResponse>(
          '/chatApp.ChatApplication/CreateUser',
          ($0.UserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateUserResponse.fromBuffer(value));
  static final _$verifyCredentials =
      $grpc.ClientMethod<$0.UserRequest, $0.VerifyCredentialsResponse>(
          '/chatApp.ChatApplication/VerifyCredentials',
          ($0.UserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.VerifyCredentialsResponse.fromBuffer(value));
  static final _$createMessage =
      $grpc.ClientMethod<$0.CreateMessageRequest, $0.CreateMessageResponse>(
          '/chatApp.ChatApplication/CreateMessage',
          ($0.CreateMessageRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateMessageResponse.fromBuffer(value));
  static final _$getMessages =
      $grpc.ClientMethod<$0.UserRequest, $0.MessageResponse>(
          '/chatApp.ChatApplication/GetMessages',
          ($0.UserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MessageResponse.fromBuffer(value));

  ChatApplicationClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateUserResponse> createUser($0.UserRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyCredentialsResponse> verifyCredentials(
      $0.UserRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$verifyCredentials, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateMessageResponse> createMessage(
      $0.CreateMessageRequest request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$createMessage, request, options: options);
  }

  $grpc.ResponseStream<$0.MessageResponse> getMessages($0.UserRequest request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$getMessages, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class ChatApplicationServiceBase extends $grpc.Service {
  $core.String get $name => 'chatApp.ChatApplication';

  ChatApplicationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UserRequest, $0.CreateUserResponse>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UserRequest.fromBuffer(value),
        ($0.CreateUserResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UserRequest, $0.VerifyCredentialsResponse>(
            'VerifyCredentials',
            verifyCredentials_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $0.UserRequest.fromBuffer(value),
            ($0.VerifyCredentialsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CreateMessageRequest, $0.CreateMessageResponse>(
            'CreateMessage',
            createMessage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateMessageRequest.fromBuffer(value),
            ($0.CreateMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UserRequest, $0.MessageResponse>(
        'GetMessages',
        getMessages_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.UserRequest.fromBuffer(value),
        ($0.MessageResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateUserResponse> createUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.UserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$0.VerifyCredentialsResponse> verifyCredentials_Pre(
      $grpc.ServiceCall call, $async.Future<$0.UserRequest> request) async {
    return verifyCredentials(call, await request);
  }

  $async.Future<$0.CreateMessageResponse> createMessage_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateMessageRequest> request) async {
    return createMessage(call, await request);
  }

  $async.Stream<$0.MessageResponse> getMessages_Pre(
      $grpc.ServiceCall call, $async.Future<$0.UserRequest> request) async* {
    yield* getMessages(call, await request);
  }

  $async.Future<$0.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $0.UserRequest request);
  $async.Future<$0.VerifyCredentialsResponse> verifyCredentials(
      $grpc.ServiceCall call, $0.UserRequest request);
  $async.Future<$0.CreateMessageResponse> createMessage(
      $grpc.ServiceCall call, $0.CreateMessageRequest request);
  $async.Stream<$0.MessageResponse> getMessages(
      $grpc.ServiceCall call, $0.UserRequest request);
}

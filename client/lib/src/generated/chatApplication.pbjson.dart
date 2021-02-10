///
//  Generated code. Do not modify.
//  source: chatApplication.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const UserRequest$json = const {
  '1': 'UserRequest',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

const CreateUserResponse$json = const {
  '1': 'CreateUserResponse',
  '2': const [
    const {'1': 'isCreated', '3': 1, '4': 1, '5': 8, '10': 'isCreated'},
  ],
};

const VerifyCredentialsResponse$json = const {
  '1': 'VerifyCredentialsResponse',
  '2': const [
    const {'1': 'isValid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
  ],
};

const CreateMessageRequest$json = const {
  '1': 'CreateMessageRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.chatApp.UserRequest', '10': 'user'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

const CreateMessageResponse$json = const {
  '1': 'CreateMessageResponse',
  '2': const [
    const {'1': 'isCreated', '3': 1, '4': 1, '5': 8, '10': 'isCreated'},
  ],
};

const MessageResponse$json = const {
  '1': 'MessageResponse',
  '2': const [
    const {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};


import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:reservme/core/network/api_client.dart';
import 'package:reservme/core/network/unauthorized_events.dart';

/// One request the app made, captured so a test can assert on the shape it
/// sent rather than only on what it did with the reply.
class RecordedRequest {
  RecordedRequest(this.options);

  final RequestOptions options;

  String get method => options.method;
  String get path => options.path;
  Map<String, dynamic> get query => options.queryParameters;

  /// The JSON body, or an empty map for a GET or a multipart upload.
  Map<String, dynamic> get body =>
      options.data is Map<String, dynamic> ? options.data as Map<String, dynamic> : {};

  /// Field names of a multipart body, for the upload endpoints.
  List<String> get formFields => options.data is FormData
      ? [
          for (final f in (options.data as FormData).fields) f.key,
          for (final f in (options.data as FormData).files) f.key,
        ]
      : const [];

  String? header(String name) => options.headers[name]?.toString();
}

/// A canned reply.
class Reply {
  const Reply(this.status, this.body);

  const Reply.ok([Map<String, dynamic> body = const {}]) : this(200, body);

  final int status;
  final Map<String, dynamic> body;
}

/// A Dio adapter that answers from a script instead of the network, so the
/// `Real*` repositories can be exercised without a server.
///
/// Replies are consumed in order. A repository that makes more calls than the
/// test scripted gets a 500, which fails loudly rather than hanging.
class StubAdapter implements HttpClientAdapter {
  StubAdapter(this._replies);

  final List<Reply> _replies;
  final requests = <RecordedRequest>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(RecordedRequest(options));
    final reply = requests.length <= _replies.length
        ? _replies[requests.length - 1]
        : const Reply(500, {'error': 'The stub ran out of replies.'});

    return ResponseBody.fromString(
      jsonEncode(reply.body),
      reply.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// An [ApiClient] wired to a [StubAdapter]. [token] stands in for a signed-in
/// session; pass null for the public endpoints.
({ApiClient client, StubAdapter stub}) stubbedClient(
  List<Reply> replies, {
  String? token = 'test-token',
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://app.reservme.pro/api'));
  final stub = StubAdapter(replies);
  dio.httpClientAdapter = stub;

  return (
    client: ApiClient(
      dio: dio,
      token: () => token,
      unauthorized: UnauthorizedEvents(),
    ),
    stub: stub,
  );
}

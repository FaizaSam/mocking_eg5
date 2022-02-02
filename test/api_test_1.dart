import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_mock_network_calls/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocking_eg4/dio_adapter_mock.dart';
import 'package:mocking_eg4/main.dart';
import 'package:mockito/mockito.dart';

void main() {
  DioAdapterMock dioAdapterMock;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
  });

  testWidgets('Test-1', (WidgetTester tester) async {
    /// create a http response that will be returned when an API is called
    var data = {'message': 'This message has been fetched from mock API-1.'};

    final responsepayload = jsonEncode(data);

    final httpResponse = ResponseBody.fromString(
      responsepayload,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    /// [when] is used for mocking API to return the http response created above
    /// It will mock any next API call for once
    /// Here, we mock the API for any requestOptions, requestStream and cancelFuture
    /// which are the parameters of the fetch method which is used to make an API request.
    //when(dioAdapterMock.fetch(any, any, any))
    //   .thenAnswer((_) async => httpResponse);

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Test',
        home: MyHomePage(
          title: 'Flutter Test',
        ),
      ),
    );

    Finder button = find.ancestor(
      of: find.text('Click here to fetch data from API-1'),
      matching: find.byType(RaisedButton),
    );

    expect(find.text('This message has been fetched from mock API-1.'),
        findsNothing);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('This message has been fetched from mock API-1.'),
        findsOneWidget);
  });
}

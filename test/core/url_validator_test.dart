import 'package:flutter_test/flutter_test.dart';
import 'package:test_task/core/utils/url_validator.dart';

void main() {
  const validator = UrlValidator();

  test('приймає http(s) посилання, у тому числі з GET-параметрами', () {
    expect(
      validator.isValid('https://flutter.webspark.dev/flutter/api'),
      isTrue,
    );
    expect(validator.isValid('http://example.com/api?page=1&size=10'), isTrue);
  });

  test('відхиляє некоректні значення', () {
    expect(validator.isValid(null), isFalse);
    expect(validator.isValid('   '), isFalse);
    expect(validator.isValid('flutter.webspark.dev'), isFalse);
    expect(validator.isValid('ftp://example.com'), isFalse);
    expect(validator.isValid('https://'), isFalse);
  });
}

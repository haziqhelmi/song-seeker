import 'package:riverpod/riverpod.dart';

final Provider<DecodeService> decodeService = Provider<DecodeService>((_) {
  return DecodeService();
});

class DecodeService {}

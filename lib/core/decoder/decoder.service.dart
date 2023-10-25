import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:song_seeker/core/constant/asset.constant.dart';
import 'package:song_seeker/core/model/song.model.dart';

final Provider<DecodeService> decodeService = Provider<DecodeService>((_) {
  return DecodeService();
});

class DecodeService {
  Future<List<Song>> decodeSongs() async {
    final String asset = await rootBundle.loadString(AssetConstant.songsJson);
    final result = jsonDecode(asset)['songs'] as List;

    return result.map((e) => Song.fromJson(e)).toList();
  }
}

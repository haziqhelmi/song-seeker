import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:song_seeker/core/decoder/decoder.service.dart';
import 'package:song_seeker/core/enum/view_state.enum.dart';
import 'package:song_seeker/core/model/song.model.dart';
import 'package:song_seeker/ui/shared/base.controller.dart';

final searchController =
    AutoDisposeNotifierProvider<SearchController, ViewState>(() {
  return SearchController();
});

class SearchController extends BaseController {
  late final DecodeService _decodeService;

  @override
  ViewState build() {
    _decodeService = ref.read(decodeService);
    return ViewState.loading;
  }

  List<Song> songList = [];
  Song? currSong;

  Future<void> init() async {
    try {
      songList = await _decodeService.decodeSongs();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  void onSelect(Song song) {
    setLoading();
    currSong = song;
    setIdle();
  }
}

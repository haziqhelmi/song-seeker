import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:song_seeker/core/enum/view_state.enum.dart';
import 'package:song_seeker/core/extension/widget.extension.dart';
import 'package:song_seeker/core/model/song.model.dart';
import 'package:song_seeker/core/navigation/navigation.service.dart';
import 'package:song_seeker/ui/ranking/ranking.controller.dart';
import 'package:song_seeker/ui/shared/style/theme_color.dart';
import 'package:song_seeker/ui/shared/style/theme_style.dart';

class RankingView extends ConsumerStatefulWidget {
  const RankingView({super.key});

  @override
  ConsumerState<RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends ConsumerState<RankingView> {
  @override
  void initState() {
    Future.microtask(
        () async => await ref.read(rankingController.notifier).init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ViewState state = ref.watch(rankingController);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => ref.read(navigationService).pop(),
          icon: Icon(Icons.west_rounded),
        ),
        centerTitle: true,
        title: Text('Top 500', style: ThemeStyle.title),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(ViewState state) {
    if (state == ViewState.loading) {
      return CircularProgressIndicator(color: ThemeColor.primaryBlue).center();
    } else {
      return _buildListView();
    }
  }

  Widget _buildListView() {
    final List<Song> songList = ref.read(rankingController.notifier).songList;

    return ListView.builder(
      itemCount: songList.length,
      itemBuilder: (_, i) {
        return ListTile(
          minVerticalPadding: 16,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          isThreeLine: false,
          tileColor: ThemeColor.primaryBlue.withOpacity(0.25),
          leading: CircleAvatar(
            backgroundColor: ThemeColor.primaryYellow.withOpacity(0.75),
            child: Text(
              songList[i].rank.toString(),
            ),
          ),
          title: Text(
            songList[i].title,
            style: ThemeStyle.subHeadingBold,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                songList[i].artist,
                style: ThemeStyle.body2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).expanded(),
              Text(
                songList[i].year.toString(),
                style: ThemeStyle.body2,
              ).paddingOnly(left: 16),
            ],
          ),
        ).paddingOnly(
          left: 8,
          top: i == 0 ? 24 : 8,
          right: 8,
          bottom: i == songList.length - 1 ? 32 : 8,
        );
      },
    );
  }
}

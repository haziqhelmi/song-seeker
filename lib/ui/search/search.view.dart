import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:song_seeker/core/enum/view_state.enum.dart';
import 'package:song_seeker/core/extension/string.extension.dart';
import 'package:song_seeker/core/extension/widget.extension.dart';
import 'package:song_seeker/core/model/song.model.dart';
import 'package:song_seeker/core/navigation/navigation.service.dart';
import 'package:song_seeker/ui/search/search.controller.dart';
import 'package:song_seeker/ui/shared/style/theme_color.dart';
import 'package:song_seeker/ui/shared/style/theme_style.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  @override
  void initState() {
    Future.microtask(
        () async => await ref.read(searchController.notifier).init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ViewState state = ref.watch(searchController);

    return Scaffold(
      appBar: _buildAppBar(ref),
      body: _buildBody(state),
    );
  }

  AppBar _buildAppBar(WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        onPressed: () => ref.read(navigationService).pop(),
        icon: Icon(Icons.west_rounded),
      ),
      centerTitle: true,
      title: Text('Search', style: ThemeStyle.title),
    );
  }

  Widget _buildBody(ViewState state) {
    if (state == ViewState.loading) {
      return CircularProgressIndicator(
        color: ThemeColor.primaryYellow,
      ).center();
    } else {
      return _buildContent();
    }
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildTextField(),
        _buildDisplayCard(),
      ],
    ).paddingAll(16);
  }

  Widget _buildTextField() {
    final List<Song> songs = ref.read(searchController.notifier).songList;

    return Autocomplete<Song>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text == '') {
          return List.empty();
        } else {
          return songs.where(
            (e) =>
                e.title.toLowerCase().contains(value.text.toLowerCase()) ||
                e.artist.toLowerCase().contains(value.text.toLowerCase()),
          );
        }
      },
      optionsViewBuilder: (_, onSelected, options) => Material(
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(height: 1, thickness: 1),
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(options.elementAt(i).title),
            subtitle: Text('by ${options.elementAt(i).artist}'),
            onTap: () => onSelected.call(options.elementAt(i)),
          ),
        ),
      ).sizedBox(width: 50),
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: () {
            FocusManager.instance.primaryFocus?.unfocus();
            onFieldSubmitted.call();
          },
          decoration: InputDecoration(
            hintText: 'Type in a song/artist',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ThemeColor.white.withOpacity(0.5), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColor.primaryBlue, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        );
      },
      onSelected: (Song selection) {
        debugPrint('You just selected ${selection.title}');
        ref.read(searchController.notifier).onSelect(selection);
        FocusManager.instance.primaryFocus?.unfocus();
      },
      displayStringForOption: (option) => option.title,
    ).paddingOnly(bottom: 32);
  }

  Widget _buildDisplayCard() {
    final Song? currSong = ref.read(searchController.notifier).currSong;
    final Map<String, dynamic> songMap = {
      'ranking': currSong?.rank,
      'title': currSong?.title,
      'artist': currSong?.artist,
      'album': currSong?.album,
      'year': currSong?.year
    };

    return Container(
      padding: EdgeInsets.all(24),
      constraints: BoxConstraints(maxHeight: 200, minHeight: 200),
      decoration: BoxDecoration(
        color: ThemeColor.primaryGray,
        borderRadius: BorderRadius.circular(24),
      ),
      child: currSong != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                songMap.length,
                (i) => Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 70,
                          child: Text(
                            '${songMap.keys.map((e) => e).toList()[i].toString().titleCase()}: ',
                            style: ThemeStyle.body1,
                          ),
                        ),
                        Text(
                          songMap.values.map((e) => e).toList()[i].toString(),
                          style: ThemeStyle.body2,
                        ).expanded()
                      ],
                    ).paddingOnly(bottom: 8),
                  ],
                ),
              ))
          : Text(
              'Nothing to see here. Try searching a song!',
              style: ThemeStyle.body2,
            ).center(),
    );
  }
}

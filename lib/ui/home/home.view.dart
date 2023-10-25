import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:song_seeker/core/decoder/decoder.service.dart';
import 'package:song_seeker/core/extension/widget.extension.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    Future.microtask(
        () async => print(await ref.read(decodeService).decodeSongs()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('Hello, World!').center(),
    );
  }
}

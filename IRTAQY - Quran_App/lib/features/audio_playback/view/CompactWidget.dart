
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/features/audio_playback/view/PlayBackControlsCompact.dart';
import 'package:quran_app/features/audio_playback/view/SurahAndReciterText.dart';
import 'package:quran_app/features/reciter_selection/view_model/selectedReciterProvider.dart';

class CompactContainer extends ConsumerWidget {
  final VoidCallback onClose;
  final Function rebuild;

  const CompactContainer({
    super.key,

    required this.onClose,
    required this.rebuild,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedReciter = ref.watch(selectedReciterProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF087F23)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: selectedReciter != null ? selectedReciter.imageUrl : "",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(child: SurahAndReciterText()),

          PlaybackControls(rebuild: rebuild),
          IconButton(
            icon: const Icon(Icons.close, size: 25, color: Colors.white),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

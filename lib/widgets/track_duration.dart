import 'package:flutter/material.dart';

class TrackDuration extends StatelessWidget {
  final Duration duration;
  final TextStyle? style;
  const TrackDuration(this.duration, {this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    return Text(
      '$minutes:${seconds.toString().padLeft(2, '0')}',
      style: style,
    );
  }
}

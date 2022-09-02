import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotifly/models/models.dart';
import 'package:spotify_api/models/track.dart';

class TracksList extends StatelessWidget {
  final List<Track> tracks;

  const TracksList({
    Key? key,
    required this.tracks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle =
        TextStyle(color: Theme.of(context).textTheme.caption!.color);

    return DataTable(
      columnSpacing: 0,
      dataRowColor: MaterialStateColor.resolveWith(_getDataRowColor),
      dividerThickness: 0,
      headingTextStyle:
          Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0),
      dataRowHeight: 54.0,
      showCheckboxColumn: false,
      columns: [
        DataColumn(label: Text('#', style: textStyle)),
        DataColumn(label: Text('TITLE', style: textStyle)),
        DataColumn(label: Text('ALBUM', style: textStyle)),
        DataColumn(
            label: Icon(
          Icons.access_time,
          color: Theme.of(context).textTheme.caption!.color,
          size: 18,
        ),),
      ],
      rows: tracks.map((e) {
        final index = tracks.indexOf(e) + 1;
        final selected =
            context.watch<CurrentTrackModel>().selected?.id == e.id;
        final accentTextStyle = TextStyle(
          color: selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).iconTheme.color,
        );
        return DataRow(
          cells: [
            DataCell(Text(index.toString(), style: textStyle)),
            DataCell(Text.rich(TextSpan(children: [
              TextSpan(text: e.name, style: accentTextStyle),
              const TextSpan(text: '\n'),
              TextSpan(text: e.artists.first.name, style: textStyle),
            ]))
                // e.title, style: textStyle),
                ),
            DataCell(
              Text(e.album.name, style: textStyle),
            ),
            DataCell(
              Text(Duration(milliseconds: e.duration_ms).toString(), style: textStyle),
            ),
          ],
          selected: selected,
          // onSelectChanged: (_) =>
          //     context.read<CurrentTrackModel>().selectTrack(e),
        );
      }).toList(),
    );
  }

  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };

    if (states.any(interactiveStates.contains)) {
      return Colors.white.withOpacity(0.1);
    }
    //return Colors.green; // Use the default value.
    return Colors.transparent;
  }
}

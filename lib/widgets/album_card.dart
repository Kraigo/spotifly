import 'package:flutter/material.dart';

class AlbumCard extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final String? description;
  final Color color;

  final void Function()? onTap;

  const AlbumCard({
    this.name,
    this.imageUrl,
    this.description,
    this.color = Colors.green,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 254,
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor,
        child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.0),
            highlightColor: color.withOpacity(0.3),
            splashColor: color.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null)
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (name != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        name!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(overflow: TextOverflow.fade),
                        softWrap: false,
                      ),
                    ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        description!,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(overflow: TextOverflow.ellipsis),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}

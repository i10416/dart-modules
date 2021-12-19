import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({required this.child, this.title, this.subtitle, Key? key})
      : super(key: key);

  final Widget child;
  final Widget? title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 36, 12, 0),
                child: title),
          if (subtitle != null)
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                child: subtitle),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            child: child,
          )
        ],
      );
}

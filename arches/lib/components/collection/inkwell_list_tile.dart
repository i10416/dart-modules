import 'package:flutter/material.dart';

class InkwellListTile extends StatelessWidget {
  const InkwellListTile(
      {required this.title,
      this.subtitle,
      this.leading,
      this.onTap,
      this.trailing,
      this.verticalPadding = 4,
      this.horizontalPadding = 12,
      this.showSeparator = false,
      Key? key})
      : super(key: key);

  final void Function()? onTap;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final double verticalPadding, horizontalPadding;
  final bool showSeparator;

  @override
  Widget build(BuildContext context) => Material(
      shape: showSeparator
          ? Border(
              bottom:
                  BorderSide(width: 0.4, color: Theme.of(context).dividerColor))
          : null,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: leading,
          contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          title: title,
          subtitle: subtitle,
          trailing: trailing,
        ),
      ));
}

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? subtitleWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final bool implyTrailing;
  final Color? tileColor;
  final bool selected;
  final bool dense;

  const CustomListTile({
    Key? key,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.onTap,
    this.onLongPress,
    this.tileColor,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.implyTrailing = false,
    this.selected = false,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fgColor = selected
        ? Theme.of(context).colorScheme.onSecondaryContainer
        : Theme.of(context).colorScheme.onSurfaceVariant;
    return ListTile(
      tileColor: tileColor,
      enabled: enabled,
      selected: selected,
      dense: dense,
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: fgColor),
            )
          : titleWidget,
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : subtitleWidget,
      leading: leading,
      trailing: implyTrailing
          ? Icon(
              Icons.chevron_right,
              color: fgColor,
            )
          : trailing,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

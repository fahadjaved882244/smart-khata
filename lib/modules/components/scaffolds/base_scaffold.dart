import 'package:flutter/material.dart';
import 'package:khata/themes/app_sizes.dart';

class BaseScaffold extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget child;
  final bool resizeToAvoidBottomInset;
  final bool noPadding;
  final Widget? floatingActionButton;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  const BaseScaffold({
    Key? key,
    required this.child,
    this.title,
    this.titleWidget,
    this.actions,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.noPadding = false,
    this.centerTitle,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: centerTitle,
        title: titleWidget ??
            Text(
              title!,
              style:
                  style.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
        actions: actions,
      ),
      drawer: drawer,
      body: Padding(
        padding: noPadding
            ? EdgeInsets.zero
            : const EdgeInsets.all(AppSizes.smallPadding),
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}

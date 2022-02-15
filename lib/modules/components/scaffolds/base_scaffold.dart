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
  final bool isLoading;
  final bool noPadding;
  final Widget? floatingActionButton;
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
    this.isLoading = false,
    this.noPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.bold);
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        title: titleWidget ??
            Text(
              title!,
              style:
                  style.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
        actions: actions,
      ),
      drawer: drawer,
      body: Column(
        children: [
          if (isLoading) const LinearProgressIndicator(),
          Expanded(
            child: IgnorePointer(
              ignoring: isLoading,
              child: Padding(
                padding: noPadding
                    ? EdgeInsets.zero
                    : const EdgeInsets.all(AppSizes.smallPadding),
                child: child,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}

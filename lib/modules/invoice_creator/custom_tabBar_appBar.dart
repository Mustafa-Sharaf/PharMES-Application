import 'package:flutter/material.dart';

class CustomerTabsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<int> onTabChanged;
  final int tabCount;
  final Color indicatorColor;

  const CustomerTabsAppBar({
    super.key,
    required this.onTabChanged,
    this.tabCount = 7,
    this.indicatorColor = Colors.blue,
  });

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: null,
      bottom: TabBar(
        isScrollable: true,
        indicatorColor: indicatorColor,
        tabs: List.generate(
          tabCount,
              (index) => Tab(text: "👤 زبون ${index + 1}"),
        ),
        onTap: onTabChanged,
      ),
    );
  }
}

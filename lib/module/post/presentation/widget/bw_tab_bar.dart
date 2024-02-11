import 'package:flutter/material.dart';

class BWTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> options;
  const BWTabBar({
    super.key,
    required this.tabController,
    required this.options
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.black,
      controller: tabController,
      labelPadding: const EdgeInsets.all(0),
      indicatorPadding: const EdgeInsets.all(0),
      tabs: List.generate(options.length, (index) {
          return Container(
            padding: const EdgeInsets.all(0),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                topRight: ((index + 1) == options.length) ? const Radius.circular(5) : Radius.zero,
                bottomRight: ((index + 1) == options.length) ? const Radius.circular(5) : Radius.zero,
                topLeft: (index == 0) ? const Radius.circular(5) : Radius.zero,
                bottomLeft: (index == 0) ? const Radius.circular(5) : Radius.zero,
            )),
            child: Tab(
              child: Text(options[index]),
            ),
          );
        }
      )
    );
  }
}
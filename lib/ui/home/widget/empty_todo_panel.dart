import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpletodo/common/theme.dart';

class EmptyTodoPanel extends StatefulWidget {
  const EmptyTodoPanel({super.key, required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  State<EmptyTodoPanel> createState() => _EmptyTodoPanelState();
}

class _EmptyTodoPanelState extends State<EmptyTodoPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "일정이 없습니다.\n일정을 추가해주세요.",
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          const SizedBox(height: 12.0),
          IconButton(
            onPressed: () {
              _controller.forward(from: 0.0).then((_) {
                widget.onRefresh();
              });
            },
            iconSize: 32.0,
            color: context.colorTheme.onSurface,
            icon: Spin(
              spins: 1.0,
              duration: const Duration(milliseconds: 1500),
              manualTrigger: true,
              controller: (ctrl) => _controller = ctrl,
              curve: Curves.fastOutSlowIn,
              child: const Icon(FontAwesomeIcons.arrowsRotate, size: 24.0),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BootstrapContainer extends StatelessWidget {
  const BootstrapContainer({
    required this.child,
    this.isFluid = false,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final bool isFluid;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (builder, constraints) {
          double maxWidth = double.infinity;

          if (constraints.maxWidth >= 576) {
            maxWidth = 540;
          }

          if (constraints.maxWidth >= 768) {
            maxWidth = 720;
          }

          if (constraints.maxWidth >= 992) {
            maxWidth = 960;
          }

          if (constraints.maxWidth >= 1200) {
            maxWidth = 1140;
          }

          if (constraints.maxWidth >= 1400) {
            maxWidth = 1320;
          }

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isFluid ? double.infinity : maxWidth,
            ),
            child: child,
          );
        },
      ),
    );
  }
}

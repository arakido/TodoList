import 'package:flutter/material.dart';
import 'package:todo_list/page/new_todo_group_page.dart';

Route pageOpenRoute(builderCallback) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) {
      return builderCallback();
    },
    transitionsBuilder: (_, animation, ____, child) => ScaleTransition(
      scale: Tween<double>(
        begin: 1.5,
        end: 1,
      ).animate(
        CurvedAnimation(parent: animation, curve: const Interval(0.5, 1, curve: Curves.linear)),
      ),
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(parent: animation, curve: const Interval(0, 0.5, curve: Curves.linear)),
        ),
        child: child,
      ),
    ),
  );
}

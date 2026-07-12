import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/src/core/router/router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

typedef HomeDetailCardModel = ({String title, VoidCallback openDetail});

HomeDetailCardModel useHomeDetailCard({required String id}) {
  final context = useContext();

  void openDetail() {
    context.pushNamed(AppRoute.detail.name, pathParameters: {'id': id});
  }

  return (title: 'Open  $id', openDetail: openDetail);
}

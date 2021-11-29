import 'dart:async';

import 'package:flutter/widgets.dart';

class StreamListener<T> extends StatefulWidget {
  const StreamListener(
      {required this.stream,
      required this.builder,
      required this.listener,
      Key? key})
      : super(key: key);

  final Stream<T> stream;
  final Widget Function(BuildContext) builder;
  final void Function(T, [BuildContext?]) listener;

  @override
  _StreamListenerState<T> createState() => _StreamListenerState();
}

class _StreamListenerState<T> extends State<StreamListener<T>> {
  late final StreamSubscription<T> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen((event) {
      widget.listener(event, context);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}

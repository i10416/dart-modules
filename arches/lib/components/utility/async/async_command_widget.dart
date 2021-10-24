import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// AsyncCommandState is one of (_Idle, _Loading, FeedBack)
///
/// _Idle is the state where async command is ready to execute.
///
///
/// _Loading is the state where async command is not ready to execute.
///
///
/// For example, imagine situation where you have a button
/// whose state(hence the command to be executed) changes based on current follow state.
/// (e.g. If following, run un-follow command on tap, and vice versa).
///
/// Button state is not ready when
/// 1. application has yet to fetch current follow state
/// 2. button is executing command (because async command can fail and does not immediately finish.)
///
///
/// FeedBack is the state where execution of async command is finished.
/// FeedBack has two sub-class SuccessFeedback and FailureFeedback.
///
/// This state is useful when you want to show different
/// feedback based on the result of executed async command and then back to Ready state.
///
abstract class _AsyncCommandState {}

class _Idle extends _AsyncCommandState {}

class Ready extends _Idle {
  Ready({required this.cmdId, required this.onTap});
  final String cmdId;
  final void Function() onTap;
}

class Cmd<T> {
  Cmd({required this.cmdId, required this.apply});
  final String cmdId;
  final Future<T> Function() apply;
}

class _Loading extends _AsyncCommandState {}

/// [FeedBack] represents the state of widget after running command which returns value of type [T].
abstract class FeedBack extends _AsyncCommandState {
  FeedBack({this.always});

  /// this function is executed everytime feedback event arrives.
  final void Function()? always;
}

class SuccessFeedback extends FeedBack {
  SuccessFeedback({this.onSuccess, void Function()? always})
      : super(always: always);

  /// This function is executed after [always] function if [FeedBack] is [SuccessFeedback].
  final void Function()? onSuccess;
}

class FailureFeedback extends FeedBack {
  FailureFeedback({this.onFailure, void Function()? always})
      : super(always: always);

  /// This function is executed after [always] function if [Feedback] is [FailureFeedback].
  final void Function()? onFailure;
}

/// [AsyncCommandWidget] abstracts stateful widgets whose state can change according to async command execution.
/// (e.g. form submission)
class AsyncCommandWidget<T> extends StatefulWidget {
  const AsyncCommandWidget(
      {required this.mapResult,
      required this.feedbackDuration,
      required this.builder,
      required this.onSuccess,
      required this.stream,
      required this.onFailure,
      required this.onLoading,
      Key? key})
      : super(key: key);

  final Stream<Cmd<T>> stream;

  /// [builder] runs when async command is ready to execute.
  final Widget Function(BuildContext, Ready ready) builder;

  /// [mapResult] maps result of command to state of this widget: FeedBack<T>.
  final FeedBack Function(T cmdResult) mapResult;
  final Duration feedbackDuration;
  final Widget onLoading;
  final Widget onSuccess;
  final Widget onFailure;

  @override
  _AsyncCommandWidgetState<T> createState() => _AsyncCommandWidgetState<T>();
}

class _AsyncCommandWidgetState<T> extends State<AsyncCommandWidget<T>> {
  _AsyncCommandWidgetState();

  late final Sink<_AsyncCommandState> _sink;
  late final Stream<_AsyncCommandState> _stream;
  @override
  void initState() {
    final _state = BehaviorSubject<_AsyncCommandState>();
    _sink = _state.sink;
    _stream = Rx.combineLatest2<_AsyncCommandState, Cmd<T>, _AsyncCommandState>(
        _state, widget.stream, (state, cmd) {
      if (state is _Loading) {
        return state;
      } else if (state is _Idle) {
        void onTap() {
          _sink.add(_Loading());
          cmd.apply().then((result) {
            final feedback = widget.mapResult(result);
            _sink.add(feedback);
          });
        }

        return Ready(cmdId: cmd.cmdId, onTap: onTap);
      } else /*FeedBack*/ {
        return state;
      }
    });

    _sink.add(_Idle());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            if (data is Ready) {
              return widget.builder(context, data);
            } else if (data is FeedBack) {
              Future<void>.delayed(widget.feedbackDuration)
                  .then((_) => _sink.add(_Idle()));
              data.always?.call();
              if (data is SuccessFeedback) {
                data.onSuccess?.call();
                return widget.onSuccess;
              } else {
                (data as FailureFeedback).onFailure?.call();
                return widget.onFailure;
              }
            } else /** data is [_Loading] */ {
              return widget.onLoading;
            }
          } else /** data is yet to arrive or data is error*/ {
            return widget.onLoading;
          }
        });
  }
}

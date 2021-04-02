import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
/**
 * 封装streambuilder
 * @author yinlei
 */

class GlobalState{}

class GlobalLoadingState extends GlobalState{}

class GlobalErrorState extends GlobalState{}

class GlobalContentState<T> extends GlobalState {
  T t;
  GlobalContentState(this.t);
}

typedef GlobalContentBuilder<T> = Widget Function(BuildContext context, T t);

class StateManager {

  StreamController<GlobalState> streamController;

  StateManager() {
    streamController = StreamController();
  }

  void dispose() {
    if(streamController != null) {
      streamController.close();
    }
  }

  void loading() {
    streamController.sink.add(GlobalLoadingState());
  }

  void error() {
    streamController.sink.add(GlobalErrorState());
  }

  void content<T>(T t) {
    streamController.sink.add(GlobalContentState(t));
  }
}

class YlStreamBuilder<T> extends StatefulWidget {
  Widget loading = appCardPageLightSkeleton();
  Widget error = Text('出错啦');
  GlobalContentBuilder builder;

  StreamController<GlobalState> streamController;
  YlStreamBuilder({this.streamController, this.builder, this.loading, this.error});

  @override
  _YlStreamBuilderState<T> createState() => _YlStreamBuilderState<T>();
}

class _YlStreamBuilderState<T> extends State<YlStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GlobalState>(
      stream: widget.streamController.stream,
      initialData: GlobalLoadingState(),
      builder: (context, snap) {
        Widget child = widget.loading;
        if(!snap.hasData){
          child = widget.loading;
        }else {
          if (snap.hasError) {
            child = widget.error;
          } else {
            switch (snap.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                child = widget.loading;
                break;
              case ConnectionState.active:
                if (snap.data is GlobalLoadingState) {
                  child = widget.loading;
                } else if (snap.data is GlobalErrorState) {
                  child = widget.error;
                } else if (snap.data is GlobalContentState) {
                  child = widget.builder(
                      context, (snap.data as GlobalContentState).t);
                }
                break;
              case ConnectionState.done:
                if (snap.data is GlobalLoadingState) {
                  child = widget.loading;
                } else if (snap.data is GlobalErrorState) {
                  child = widget.error;
                } else if (snap.data is GlobalContentState) {
                  child = widget.builder(
                      context, (snap.data as GlobalContentState).t);
                }
                break;
            }
          }
        }
        return Container(child: child);
      }
    );
  }
}

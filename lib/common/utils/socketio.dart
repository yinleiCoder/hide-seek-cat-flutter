import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/global.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:async';
/**
 * real time chat: socket.io
 * https://github.com/rikulo/socket.io-client-dart
 */
class AppSocketIo {
  /// singleton design mode.
  static AppSocketIo _instance = AppSocketIo._internal();
  factory AppSocketIo() => _instance;
  IO.Socket _socket;
  IO.Socket get socket => _socket;
  // static StreamSocket streamSocket;

  AppSocketIo._internal() {
    // streamSocket = StreamSocket();
    _socket = IO.io(SERVER_SOCKET_URL,
        OptionBuilder()
            .setTransports(['websocket'])
            .build()
    );
    _socket.onConnect((data) {
      print('socket.io connect: ${_socket.id}');
      _socket.emit('login', AppGlobal.profile.user?.uid??'');
    });

    _socket.onConnectError((err) {
      print('连接出错啦: ${err}');
    });
    _socket.onConnectTimeout((_) {
      print('连接超时啦');
    });
    _socket.onDisconnect((_) {
      print('断开连接啦');
    });
    _socket.onError((err) {
      print('出错: ${err}');
    });
    _socket.onReconnect((_) {
      print('重连');
    });
    _socket.onReconnectAttempt((_) {
      print('企图重连');
    });
    _socket.onReconnecting((_) {
      print('重新连接中……');
    });
    _socket.onReconnectFailed((_) {
      print('重连失败');
    });
    // _socket.on('chat_text', (data) {
    //   print('接收到对方消息: ${data}');
    //   // streamSocket.addResponse
    // });
    _socket.onDisconnect((data) => print('disconnect'));
  }

  void dispose() {
    _socket.dispose();
  }

}

/// step1: Stream setup
class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }

}

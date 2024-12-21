import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../database/api/end_points.dart';

abstract class WebSocketDataSource {
  Stream<String> getMessageStream();
  Future<void> sendMessage(String message);
  Future<void> joinRoom(String lessonId);
  Future<void> connect(String url);
  Future<void> disconnect();
}

class WebSocketDataSourceImpl implements WebSocketDataSource {
  final _controller = StreamController<String>();
  late IO.Socket _socket;

  @override
  Future<void> connect(String url) async {
    _socket = IO.io(EndPoints.baseUrl,
        IO.OptionBuilder().setTransports(['websocket']).build());
    _socket.onConnect((_) => print("Connected to WebSocket"));
    _socket.on(url, (newQuestion) {
      _controller.sink.add(newQuestion);
    });
    _socket.onDisconnect((_) => print("Disconnected from WebSocket"));
  }

  @override
  Stream<String> getMessageStream() => _controller.stream;

  @override
  Future<void> sendMessage(String message) async {
    _socket.emit('joinLessonRoom', message);
  }

  @override
  Future<void> disconnect() async {
    _socket.disconnect();
    _socket.off('newQuestion');
    _socket.dispose();
    await _controller.close();
  }

  @override
  Future<void> joinRoom(String lessonId) async {
    _socket.emit('joinLessonRoom', lessonId);
  }
}

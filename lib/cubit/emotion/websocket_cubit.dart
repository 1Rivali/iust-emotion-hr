import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Define states for WebSocket communication
abstract class WebSocketState {}

class WebSocketInitial extends WebSocketState {}

class WebSocketConnected extends WebSocketState {}

class WebSocketDisconnected extends WebSocketState {}

class WebSocketError extends WebSocketState {
  final String message;

  WebSocketError(this.message);
}

class WebSocketSendSuccess extends WebSocketState {
  final String emotion;

  WebSocketSendSuccess({required this.emotion});
}

class WebSocketCubit extends Cubit<WebSocketState> {
  WebSocketChannel? _channel;

  WebSocketCubit() : super(WebSocketInitial());

  void connect(String url) {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      emit(WebSocketConnected());
    } catch (e) {
      emit(WebSocketError('Failed to connect: $e'));
    }
  }

  void disconnect() {
    try {
      _channel?.sink.close();
      emit(WebSocketDisconnected());
    } catch (e) {
      emit(WebSocketError('Failed to disconnect: $e'));
    }
  }

  void sendMessage(String message) {
    try {
      _channel?.sink.add(message);
      _channel?.stream.listen((event) {
        print(event);
      });
    } catch (e) {
      emit(WebSocketError('Failed to send message: $e'));
    }
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }
}

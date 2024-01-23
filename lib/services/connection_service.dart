// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:assetcomply_notifier/constants/strings.dart';
import 'package:assetcomply_notifier/models/data_model.dart';
import 'package:assetcomply_notifier/screens/select_lab_screen.dart';
import 'package:assetcomply_notifier/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

typedef ConnectionCallback = void Function(bool isConnected);
typedef MessageCallback = void Function(Map<String, dynamic> message);

class SocketConnectionService {
  IOWebSocketChannel? channel;
  List<Map<String, dynamic>> messages = [];
  Map<String, dynamic> message = {};
  bool isFirstMessage = true;
  bool isConnected = false;
  BuildContext? _context;

  SocketConnectionService();

  // Method to initialize _context with a BuildContext
  void initializeWithContext(BuildContext context) {
    _context = context;
  }

  void connectSocket(
      {required int labId,
      required int otp,
      ConnectionCallback? onConnection,
      MessageCallback? onMessage}) {
    channel = IOWebSocketChannel.connect(AppStrings.SOCKET_URL);
    // Send labId and otp after establishing the connection
    channel!.sink.add(json.encode({'id': labId, 'otp': otp}));

    channel!.stream.listen((data) {
      print(data);
      try {
        if (isFirstMessage) {
          isFirstMessage = false;

          final AuthModel authData = AuthModel.fromJson(json.decode(data));

          if (authData.connectionStatus == 1) {
            print(data);
            if (isConnected && onConnection != null) {
              onConnection(true);
            }
          }
          if (_context != null) {
            UiUtils.showSnackbar(_context!, message: authData.message);
          }
        } else {
          if (data == "ping") {
            channel!.sink.add("pong");
          } else {
            final Map<String, dynamic> dataMap = json.decode(data);
            onMessage!(dataMap);

            messages.add(dataMap);
          }
        }
      } catch (e) {
        print("Error parsing data: $e");
      }
    }, onDone: () {
      print("WebSocket Closed");
      _updateConnectionStatus(false);
      if (onConnection != null) {
        onConnection(false);
      }
      _redirectToLoginPage();
    }, onError: (error) {
      print("WebSocket Error: $error");
      _updateConnectionStatus(false);
      if (onConnection != null) {
        onConnection(false);
      }
      _redirectToLoginPage();
    });

    isConnected = true;
  }

  void _disconnectSocket() {
    channel?.sink.close();
    _updateConnectionStatus(false);
    channel = null;
  }

  void sendMessage(dynamic message) {
    channel!.sink.add(message);
  }

  void _updateConnectionStatus(bool status) {
    isConnected = status;
    isFirstMessage = true;
    if (_context != null) {
      UiUtils.showSnackbar(
        _context!,
        message: status ? "Connected" : "Disconnected",
      );
    } else {
      print(status ? "Connected" : "Disconnected");
    }
  }

  void dispose() {
    if (isConnected) {
      _disconnectSocket();
    }
  }

  void resetList() {
    messages.clear();
  }

  void _redirectToLoginPage() {
    if (_context != null) {
      Navigator.of(_context!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SelectLabScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }
}

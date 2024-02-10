import 'dart:convert';

import 'package:assetcomply_notifier/screens/lab_status_screen.dart';
import 'package:assetcomply_notifier/services/api_service.dart';
import 'package:assetcomply_notifier/services/connection_service.dart';
import 'package:assetcomply_notifier/services/local_db_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  late BuildContext _context;
  bool _isLoading = false;
  int _labId = 1;
  int _otp = 1;
  bool _connectionStatus = false;
  LabStatus _labStatus = LabStatus.labAvailable;
  Map<String, dynamic> _socketMessage = {};
  String? _patientId;
  int _totalPages = 0;
  int _currentPage = 0;

  bool get isLoading => _isLoading;
  int get labId => _labId;
  LabStatus get labStatus => _labStatus;
  Map<String, dynamic> get socketMessage => _socketMessage;
  String? get patientId => _patientId;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  final SocketConnectionService _socketConnectionService =
      SocketConnectionService();

  final AudioPlayer _audioPlayer = AudioPlayer();
  final ApiService _apiService = ApiService();
  final LocalDBService _databaseService = LocalDBService();

  set labId(int value) {
    _labId = value;
    notifyListeners();
  }

  set otp(int value) {
    _otp = value;
    notifyListeners();
  }

  set labStatus(LabStatus value) {
    _labStatus = value;
    notifyListeners();
  }

  Future<void> fetchAndStoreSerialNumbers() async {
    var serialNumbers = await _apiService.fetchSerialNumbers(
      onProgress: (currentPage, totalPages) {
        _currentPage = currentPage;
        _totalPages = totalPages;
        notifyListeners();
      },
    );
    print("Data recieved. Length: ${serialNumbers.length}");
    await _databaseService.insertSerialNumbers(serialNumbers);
  }

  getSerialNumber(String epc) async {
    notifyListeners();
    _patientId = await _databaseService.getSerialNumberByEPC(epc);
    print(_patientId);
    notifyListeners();
  }

  connectToServer(BuildContext context) async {
    _context = context;
    _socketConnectionService.initializeWithContext(context);
    _socketConnectionService.connectSocket(
      labId: _labId,
      otp: _otp,
      onConnection: (isConnected) async {
        if (isConnected) {
          _connectionStatus = isConnected;

          _isLoading = true;
          notifyListeners();
          //TODO: Don't forget to uncomment.
          await fetchAndStoreSerialNumbers();
          _isLoading = false;
          notifyListeners();
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LabStatusScreen(),
              ),
            );
          }
        }
      },
      onMessage: (message) async {
        _socketMessage = message;
        await getSerialNumber(message["epc"]);
        print(_patientId);
        switch (message['ui']) {
          case 0:
            _labStatus = LabStatus.labAvailable;
            break;
          case 1:
            playBeepSound();
            _labStatus = LabStatus.patientDetected;
            break;
          case -1:
            _labStatus = LabStatus.labOccupied;
            break;
          case 2:
            playBeepSound();
            _labStatus = LabStatus.patientCheckedOut;
            break;
          default:
            _labStatus = LabStatus.labAvailable;
            break;
        }
        notifyListeners();
      },
    );
  }

  clearEntry() {
    String message = json.encode({'action': -1, 'epc': _socketMessage['epc']});
    _socketConnectionService.sendMessage(message);
    _labStatus = LabStatus.labAvailable;
    notifyListeners();
  }

  Future<void> playBeepSound() async {
    try {
      const String path = 'sounds/beep1.mp3';
      await _audioPlayer.play(AssetSource(path));
    } catch (e) {
      if (kDebugMode) {
        print('Error playing sound: $e');
      }
    }
  }
}

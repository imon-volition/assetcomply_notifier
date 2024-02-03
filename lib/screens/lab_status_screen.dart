import 'package:assetcomply_notifier/providers/data_provider.dart';
import 'package:assetcomply_notifier/views/lab_available_view.dart';
import 'package:assetcomply_notifier/views/lab_checkout_view.dart';
import 'package:assetcomply_notifier/views/lab_occupied_view.dart';
import 'package:assetcomply_notifier/views/lab_patient_detected_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LabStatus {
  labOccupied,
  labAvailable,
  patientDetected,
  patientCheckedOut,
}

class LabStatusScreen extends StatelessWidget {
  const LabStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return  const Scaffold(
    //   body: LabCheckoutView(
    //     epc: "",
    //     inTime: "",
    //     outTime: "",
    //     duration: "",
    //   ),
    // );
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<DataProvider>(builder: (context, dataProvider, child) {
        return _labScreen(dataProvider);
      }),
    );
  }

  _labScreen(DataProvider dataProvider) {
    switch (dataProvider.labStatus) {
      case LabStatus.labAvailable:
        return Scaffold(
          body: LabAvailableView(labId: dataProvider.labId),
        );
      case LabStatus.labOccupied:
        return Scaffold(
          body: LabOccupiedView(
            labId: dataProvider.labId,
            epc: dataProvider.socketMessage['epc'],
            inTime: dataProvider.socketMessage['inTime'],
          ),
        );
      case LabStatus.patientDetected:
        return Scaffold(
          body: LabPatientDetectedView(
            epc: dataProvider.socketMessage['epc'],
            inTime: dataProvider.socketMessage['inTime'],
          ),
        );
      case LabStatus.patientCheckedOut:
        return Scaffold(
          body: LabCheckoutView(
            epc: dataProvider.socketMessage['epc'],
            inTime: dataProvider.socketMessage['inTime'],
            outTime: dataProvider.socketMessage['outTime'],
            duration: dataProvider.socketMessage['duration'],
          ),
        );
    }
  }
}

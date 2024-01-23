import 'dart:async';
import 'package:assetcomply_notifier/providers/data_provider.dart';
import 'package:assetcomply_notifier/screens/lab_status_screen.dart';
import 'package:assetcomply_notifier/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabPatientDetectedView extends StatefulWidget {
  final String epc;
  final String inTime;

  const LabPatientDetectedView({super.key, required this.epc, required this.inTime});

  @override
  State<LabPatientDetectedView> createState() => _LabPatientDetectedViewState();
}

class _LabPatientDetectedViewState extends State<LabPatientDetectedView> {
  int _counter = 10;
  Timer? _timer;
  late DataProvider _dataProvider;

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer!.cancel();
        _dataProvider.clearEntry();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _dataProvider = Provider.of<DataProvider>(context, listen: false);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFEA4155),
              const Color(0xFFEA4155).withOpacity(0.7)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              header(),
              timer(),
              description(),
              acceptButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget acceptButton() {
    return Column(
      children: [
        const Text(
          'If you believe all the details shown are correct and there are no mistakes, please press the accept button below.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 30),
        FloatingActionButton(
          onPressed: () {
            _dataProvider.labStatus = LabStatus.labOccupied;
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.check),
        ),
      ],
    );
  }

  Column description() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Serial No: ',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: Provider.of<DataProvider>(context, listen: true).patientId,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Text(
        //   '(${widget.epc})',
        //   style: const TextStyle(
        //       fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
        // ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Last viewed on ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: UiUtils.convertDateTimeToReadableFormat(widget.inTime),
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        
      ],
    );
  }

  CircleAvatar timer() {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.white,
      child: Text(
        '$_counter',
        style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          color: Color(0xFFEA4155),
        ),
      ),
    );
  }

  Text header() {
    return const Text(
      'New Patient Detected',
      style: TextStyle(
        fontSize: 48.0, // Increased font size
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}

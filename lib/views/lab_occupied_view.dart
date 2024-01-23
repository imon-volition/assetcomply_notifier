import 'package:assetcomply_notifier/providers/data_provider.dart';
import 'package:assetcomply_notifier/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabOccupiedView extends StatelessWidget {
  final String epc;
  final int labId;
  final String inTime;

  const LabOccupiedView(
      {super.key,
      required this.epc,
      required this.labId,
    
      required this.inTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFB71C1C).withOpacity(0.9),
              const Color(0xFFF44336)
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[header(), id(context), info()],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        const Icon(
          Icons.warning,
          size: 100.0,
          color: Colors.white,
        ),
        const SizedBox(height: 20.0),
        Text(
          'Cath Lab $labId Occupied',
          style: const TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const Divider(
          color: Colors.white,
          thickness: 2.0,
          indent: 30,
          endIndent: 30,
        ),
      ],
    );
  }

  Widget id(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Serial No: ',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: Provider.of<DataProvider>(context, listen: true).patientId ?? "Fetching Id...",
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Text(
        //   '($epc)',
        //   style: const TextStyle(
        //     fontSize: 14.0,
        //     fontWeight: FontWeight.w600,
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }

  Widget info() {
    return Column(
      children: [
        const Text(
          'Checked-in at',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          UiUtils.convertDateTimeToReadableFormat(inTime),
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        // RichText(
        //   textAlign: TextAlign.center,
        //   text: TextSpan(
        //     children: [
        //       const TextSpan(
        //         text: 'Checked-in at ',
        //         style: TextStyle(
        //           fontSize: 22.0,
        //           fontWeight: FontWeight.w600,
        //           color: Colors.white,
        //         ),
        //       ),
        //       TextSpan(
        //         text: UiUtils.convertDateTimeToReadableFormat(inTime),
        //         style: const TextStyle(
        //           fontSize: 22.0,
        //           fontWeight: FontWeight.w400,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class LabAvailableView extends StatelessWidget {
  final int labId;
  const LabAvailableView({super.key, required this.labId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFAED581), Color(0xFF2E7D32)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                header(),
                const Text(
                  'Waiting for Patient...',
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
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
          Icons.check_circle,
          size: 130.0,
          color: Colors.white,
        ),
        const SizedBox(height: 40.0),
        Text(
          'Cath Lab $labId Available',
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
}

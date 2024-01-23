import 'package:assetcomply_notifier/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assetcomply_notifier/constants/colors.dart';

class CircularCardButtons extends StatefulWidget {
  const CircularCardButtons({super.key});

  @override
  State<CircularCardButtons> createState() => _CircularCardButtonsState();
}

class _CircularCardButtonsState extends State<CircularCardButtons> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Wrap(
          direction: Axis.horizontal,
          children: List.generate(
              4, (index) => _buildCircularButton(index, dataProvider)),
        );
      },
    );
  }

  Widget _buildCircularButton(int index, DataProvider dataProvider) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          _selectedIndex = index;
          dataProvider.labId = index + 1;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? AppColor.primaryColor
              : Colors.transparent,
          border: Border.all(
            color: AppColor.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            'Cath Lab ${index + 1}',
            style: TextStyle(
              color: _selectedIndex == index
                  ? Colors.white
                  : AppColor.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

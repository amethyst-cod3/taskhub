import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:taskhub/styles/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFoldingCube(
        color: CustomColor.darkblue,
        size: 50,
      ),
    );
  }
}

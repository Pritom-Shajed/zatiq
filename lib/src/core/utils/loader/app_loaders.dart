import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zatiq/src/core/utils/colors/app_colors.dart';
import 'package:zatiq/src/core/utils/extensions/extensions.dart';

class AppLoaders {
  AppLoaders._();
  static Widget spinningLines({Key? key, double? size, Color? color}) {
    return SpinKitThreeBounce(key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget pulse({Key? key, double? size, Color? color}) {
    return SpinKitPulse(key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget wave({Key? key, double? size, Color? color}) {
    return SpinKitWave(key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget dancingSquare({Key? key, double? size, Color? color}) {
    return SpinKitDancingSquare(key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget foldingCube({Key? key, double? size, Color? color}) {
    return SpinKitFoldingCube(key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget cubeGrid({Key? key, double? size, Color? color}) {
    return SpinKitCubeGrid(key: key, color: color ?? AppColors.primaryColor, size: size ?? 25);
  }

  static Widget loaderWithText(BuildContext context, {String? text, Widget? loaderWidget}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 14,
        children: [loaderWidget ?? AppLoaders.cubeGrid(), Text(text ?? 'Loading...', style: context.text.bodySmall!)],
      ),
    );
  }
}

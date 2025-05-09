import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zatiq/src/core/shared/animations_widget/animated_widget_shower.dart';
import 'package:zatiq/src/core/shared/list_tile/k_list_tile/k_list_tile.dart';
import 'package:zatiq/src/features/settings/presentation/bloc/performance_overlay/bloc/performance_overlay_bloc.dart';
import 'package:zatiq/src/localization/app_locale.dart';

import '../../../../../core/utils/extensions/extensions.dart';

class PerformanceOverlayTile extends StatelessWidget {
  const PerformanceOverlayTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/performance-overlay.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Performance Overlay',
        ),
      ),
      title: Text(
        t.performanceOverlay,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Transform.scale(
        scale: 0.7,
        child: BlocBuilder<PerformanceOverlayBloc, PerformanceOverlayState>(
          builder: (_, state) => CupertinoSwitch(
            value: state.isEnabled,
            onChanged: (v) {
              context.read<PerformanceOverlayBloc>().add(ChangePerformanceOverlay(v));
            },
          ),
        ),
      ),
    );
  }
}

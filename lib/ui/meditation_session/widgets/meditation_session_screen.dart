import 'package:flutter/material.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/avatar_view.dart';

class MeditationSessionScreen extends StatelessWidget {
  static const String routeName = '/meditation-session';
  const MeditationSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBodyBehindAppBar: false,
      // appBar: AppBar(
      //   backgroundColor: AppColors.primary,
      //   elevation: 0,

      // ),
      body: SafeArea(
        left: true,
        right: true,
        bottom: true,
        top: true,
        child: Stack(
          fit: StackFit.expand,
          children: [
            OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: AppBar().preferredSize.height,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * .65,
                            width: MediaQuery.sizeOf(context).width,
                            child: ClipRect(
                              child: OverflowBox(
                                maxWidth: double.infinity,
                                alignment: Alignment.topCenter,
                                child: Hero(
                                  tag: 'avatar',
                                  child: AvatarView(
                                    size:
                                        MediaQuery.sizeOf(context).height * .7,
                                    imagePath: 'assets/images/avatar_1.webp',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SessionControls(
                            size:
                                MediaQuery.sizeOf(context).width >
                                        MediaQuery.sizeOf(context).height
                                    ? MediaQuery.sizeOf(context).height * 0.3
                                    : MediaQuery.sizeOf(context).width * .6,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AvatarView(
                          size: MediaQuery.sizeOf(context).height * .7,
                          imagePath: 'assets/images/avatar_1.webp',
                        ),
                      ),
                      Expanded(
                        child: SessionControls(
                          size: MediaQuery.sizeOf(context).height * .7,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: AppColors.onPrimary,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionControls extends StatelessWidget {
  final double size;
  const SessionControls({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    double controlsSize = size > 300 ? 300 : size;
    double controlsPadding =
        controlsSize * 0.04 > 16 ? 16 : controlsSize * 0.04;
    return Container(
      width: controlsSize,
      height: controlsSize,
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(controlsPadding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.tertiary,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: controlsSize - (controlsPadding * 2),
            height: controlsSize - (controlsPadding * 2),
            padding: EdgeInsets.all(controlsPadding),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 1),
              gradient: const LinearGradient(
                colors: [
                  AppColors.quaternary,
                  AppColors.tertiary,
                  AppColors.primary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircularProgressIndicator(
              value: 0.7,
              color: AppColors.onPrimary,
              strokeCap: StrokeCap.round,
              strokeWidth:
                  controlsSize * 0.035 > 16 ? 16 : controlsSize * 0.035,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.pause),
                const Text(
                  '10:34',
                  style: TextStyle(
                    fontSize: 28,
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '15:00',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

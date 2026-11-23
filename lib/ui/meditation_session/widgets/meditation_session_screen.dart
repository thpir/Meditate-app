import 'package:material_ui/material_ui.dart';
import 'package:meditate_app/data/repositories/user_preferences.dart';
import 'package:meditate_app/domain/models/meditation_duration.dart';
import 'package:meditate_app/domain/models/meditation_sound.dart';
import 'package:meditate_app/ui/core/theme/app_colors.dart';
import 'package:meditate_app/ui/core/ui/avatar_view.dart';
import 'package:meditate_app/ui/meditation_session/view_models/meditation_session_view_model.dart';
import 'package:provider/provider.dart';

class MeditationSessionScreen extends StatelessWidget {
  static const routeName = '/meditation-session';
  const MeditationSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final duration = args['duration'] as MeditationDuration;
    final sound = args['sound'] as MeditationSound;

    return ChangeNotifierProvider(
      create: (_) => MeditationSessionViewModel(userPrefs, duration: duration, sound: sound),
      child: const Scaffold(
        backgroundColor: AppColors.primary,
        extendBodyBehindAppBar: false,
        body: SessionBody()
      ),
    );
  }
}

class SessionBody extends StatelessWidget {
  const SessionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                                      imagePath: context.read<MeditationSessionViewModel>().selectedAvatar.imagePath,
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
                            imagePath: context.read<MeditationSessionViewModel>().selectedAvatar.imagePath,
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
        );
  }
}

class SessionControls extends StatelessWidget {
  final double size;
  const SessionControls({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    final double controlsSize = size > 300 ? 300 : size;
    final double controlsPadding =
        controlsSize * 0.04 > 16 ? 16 : controlsSize * 0.04;
    return Container(
      width: controlsSize,
      height: controlsSize,
      margin: const EdgeInsets.all(24),
      padding: EdgeInsets.all(controlsPadding),
      decoration: const BoxDecoration(
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
              value: context.watch<MeditationSessionViewModel>().progress,
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
                InkWell(
                  onTap: context.read<MeditationSessionViewModel>().playButtonPressed,
                  child: Icon(context.watch<MeditationSessionViewModel>().isPlaying
                      ? Icons.pause
                      : Icons.play_arrow),
                ),
                Text(
                  context.watch<MeditationSessionViewModel>().timePassed,
                  style: const TextStyle(
                    fontSize: 28,
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.watch<MeditationSessionViewModel>().durationText,
                  style: const TextStyle(
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

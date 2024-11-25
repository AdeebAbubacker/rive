import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

/// [RiveAnimatedIcon] is used to render animated icons with different parameters and callbacks
class RiveAnimatedIcon extends StatefulWidget {
  const RiveAnimatedIcon({
    required this.riveIcon,
    super.key,
    this.height = 20,
    this.width = 20,
    this.strokeWidth = 2,
    this.color = Colors.black,
    this.onTap,
    this.onHover,
    this.loopAnimation = false,
    this.splashColor = Colors.transparent,
  });

  /// [color] is for rendering animated icon with respected color.
  /// Default Value: [Colors.black]
  final Color color;

  /// [height] is for rendering animated icon with respected height.
  /// Default Value: [20]
  final double? height;

  /// [width] is for rendering animated icon with respected width.
  /// Default Value: [20]
  final double? width;

  /// [riveIcon] is for rendering rive animated icon with respect to the passed icon.
  /// it's a required parameter for [RiveAnimatedIcon]
  final RiveIcon riveIcon;

  /// [onTap] is a callback which is sent by user and it's used to perform actions on tap.
  /// it's an optional parameter for [RiveAnimatedIcon]
  final VoidCallback? onTap;

  /// [onHover] is a callback which is sent by user depend on his requirements.
  /// it's an  optional parameter for [RiveAnimatedIcon]
  final ValueChanged<bool>? onHover;

  /// [loopAnimation] is a boolean to set animation on loop or not.
  /// Default Value: false
  final bool loopAnimation;

  /// [splashColor] is for rendering the splash color when the icon is tapped
  /// Default value: [Colors.transparent]
  /// it's an  optional parameter for [RiveAnimatedIcon]
  final Color splashColor;

  /// [strokeWidth] is for rendering the animated icon with respected stroke width
  /// Default value: [2]
  final double strokeWidth;

  @override
  State<RiveAnimatedIcon> createState() => _RiveAnimatedIconState();
}

class _RiveAnimatedIconState extends State<RiveAnimatedIcon> {
  @override
  Widget build(BuildContext context) {
    final icon = widget.riveIcon.getRiveAsset();
    return InkWell(
      splashColor: widget.splashColor,
      highlightColor: widget.splashColor,
      onTap: () {
        if (!widget.loopAnimation) {
          // Trigger animation once
          icon.input?.change(true);
          Future.delayed(const Duration(seconds: 1), () {
            icon.input?.change(false);
          });
        } else {
          // If loopAnimation is true, keep the animation running
          icon.input?.change(true);
        }
        widget.onTap?.call();
      },
      onHover: (value) {
        widget.onHover?.call(value);
      },
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: RiveAnimation.asset(
          icon.src,
          artboard: icon.artboard,
          onInit: (artboard) {
            final controller = RiveUtil.getRiveController(
              artboard,
              stateMachineName: '${icon.stateMachineName}',
            );
            icon
              ..input = controller.findSMI('active') as SMIBool
              ..numberInput = controller.findSMI('strokeWidth') as SMINumber;

            artboard.forEachComponent((child) {
              if (child is Shape) {
                final shape = child;
                if (shape.name == icon.shapeStrokeTitle) {
                  shape.strokes.first.paint.color = widget.color;
                } else if (shape.name == icon.shapeFillTitle) {
                  shape.fills.first.paint.color = widget.color;
                }
              }
            });
            if (widget.loopAnimation) {
              icon.input?.change(true);
            } else {
              icon.input?.change(false);
            }
            icon.numberInput?.value = widget.strokeWidth - 1;
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rive Animated Icons',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RiveAnimatedIcon(
                riveIcon: RiveIcon.home,
                width: 40,
                height: 40,
                strokeWidth: 3,
                loopAnimation: false,
                onTap: () {
                  debugPrint('Icon tapped!');
                },
                color: Colors.white,
              ),
              RiveAnimatedIcon(
                riveIcon: RiveIcon.bell,
                width: 40,
                height: 40,
                strokeWidth: 3,
                loopAnimation: false,
                onTap: () {
                  debugPrint('Icon tapped!');
                },
                color: Colors.white,
              ),
              RiveAnimatedIcon(
                riveIcon: RiveIcon.profile,
                width: 40,
                height: 40,
                strokeWidth: 3,
                loopAnimation: false,
                onTap: () {
                  debugPrint('Icon tapped!');
                },
                color: Colors.white,
              ),
              RiveAnimatedIcon(
                riveIcon: RiveIcon.sliderHorizontal,
                width: 40,
                height: 40,
                strokeWidth: 3,
                loopAnimation: false,
                onTap: () {
                  debugPrint('Icon tapped!');
                },
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

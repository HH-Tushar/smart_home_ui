import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FanAnimation extends StatefulWidget {
  final bool isOn;
  final String smartDeviceName;
  final String iconPath;
  final Function(bool)? onChanged;
  const FanAnimation(
      {Key? key,
      required this.isOn,
      required this.smartDeviceName,
      required this.onChanged,
      required this.iconPath})
      : super(key: key);

  @override
  State<FanAnimation> createState() => _FanAnimationState();
}

class _FanAnimationState extends State<FanAnimation>
    with SingleTickerProviderStateMixin {
late double clock;
  late AnimationController _controller;
  late Animation<double> _animation;

  void isAnimated(bool isOn) {
    if (isOn) {
      _controller.forward(from: clock);
    } else {
      _controller.stop();
      clock=_controller.value;

    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: widget.isOn
              ? const Color.fromARGB(44, 164, 167, 189)
              : Colors.grey[850]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 1),
              // icon
              RotationTransition(
                turns: _controller,
                child: Image.asset(
                  widget.iconPath,
                  height: 65,
                  color:
                      widget.isOn ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
              ),
              const SizedBox(height: 10),

              // smart device name + switch
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        widget.smartDeviceName,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: widget.isOn ? Colors.black : Colors.white,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                        ),
                        // style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: CupertinoSwitch(
                      activeColor: Colors.grey.shade400,
                      trackColor: Colors.grey.shade200,
                      thumbColor: Colors.grey[850],
                      value: widget.isOn,
                      //onChanged: widget.onChanged,
                      onChanged:(value){
                        isAnimated(value);
                        widget.onChanged!(value);
                        if (kDebugMode) {
                          print(value);
                        }
                      } ,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class SmartDeviceAnimation extends StatefulWidget {
  final bool isOn;
  final String smartDeviceName;
  final String iconPath;
  final Function(bool)? onChanged;
  const SmartDeviceAnimation({Key? key, required this.isOn, required this.smartDeviceName, required this.iconPath, this.onChanged}) : super(key: key);

  @override
  State<SmartDeviceAnimation> createState() => _SmartDeviceAnimationState();
}

class _SmartDeviceAnimationState extends State<SmartDeviceAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late  Animation<double> _animation;

  void startAnimation(bool isOn) {
    _controller.reset();
   isOn? _controller.forward():_controller.reverse(from: 1);
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: widget.isOn ? const Color.fromARGB(44, 164, 167, 189):Colors.grey[850] ,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 1),
              // icon
              ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  widget.iconPath,
                  height: 65,
                  color: widget.isOn ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
              ),
              SizedBox(height: 10),
              // smart device name + switch
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        widget.smartDeviceName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color:widget.isOn ? CupertinoColors.black : CupertinoColors.white,
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
                      onChanged:(value){
                        widget.onChanged!(value);
                        startAnimation(value);
                      }
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

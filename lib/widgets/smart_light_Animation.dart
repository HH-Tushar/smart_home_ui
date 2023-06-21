import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmartLightAnimation extends StatefulWidget {
  final bool isOn;
  final String smartDeviceName;
  final String iconPath;
  final Function(bool)? onChanged;
  const SmartLightAnimation({Key? key, required this.isOn, required this.smartDeviceName, required this.iconPath,required this.onChanged}) : super(key: key);

  @override
  State<SmartLightAnimation> createState() => _SmartLightAnimationState();
}

class _SmartLightAnimationState extends State<SmartLightAnimation> {
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
               // curve: Curves.linearToEaseOut,
                curve: Curves.linear,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (widget.isOn)
                      BoxShadow(
                        color: const Color(0xffEEDD82).withOpacity(0.6),
                        blurRadius: 20.0,
                        spreadRadius: 30.0,
                      ),
                  ],
                ),
                child: Image.asset(
                  widget.iconPath,
                  height: 65,
                  color: widget.isOn ? Colors.grey.shade700 : Colors.grey.shade300,
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
                        widget.smartDeviceName,softWrap: true,
                        //overflow: TextOverflow.ellipsis,
                        maxLines: 2,

                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color:widget.isOn ? Colors.black : Colors.white,
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
                      onChanged: widget.onChanged,
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

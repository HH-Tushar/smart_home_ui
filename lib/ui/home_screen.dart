import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/fan_Animation.dart';
import '../widgets/smart_device_animation.dart';
import '../widgets/smart_light_Animation.dart';
import 'devices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  // list of smart devices
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Smart Light", "assets/light-bulb.png", true,'glow'],
    ["Smart AC", "assets/air-conditioner.png", false,'bounce'],
    ["Smart TV", "assets/smart-tv.png", false,'bounce'],
    ["Smart Fan", "assets/fan.png", true,'fan'],
  ];


  // power button switched
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // menu icon
                  InkWell(

                    child: Image.asset(
                      'assets/menu.png',
                      height: 45,
                      color: Colors.grey[800],
                    ),
                    onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const Devices()));},
                  ),

                  //RotatingAnimationExample

                  // account icon
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: CupertinoColors.systemGrey5,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 15),

            // welcome home
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Home,",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Hasibul Hasan Tushar',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Color.fromARGB(255, 204, 204, 204),
              ),
            ),

            const SizedBox(height: 20),

            // smart devices grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "Smart Devices",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // grid
            Expanded(
              child: GridView.count(
                childAspectRatio: 0.9,
                shrinkWrap: true,
                semanticChildCount: 8,
                crossAxisCount: 2,
                children: [
                  FanAnimation(
                      isOn: mySmartDevices[3][2],
                    smartDeviceName: mySmartDevices[3][0], iconPath: mySmartDevices[3][1],
                      onChanged: (value) => powerSwitchChanged(value, 3),
                  ),


                  SmartDeviceAnimation(
                    isOn: mySmartDevices[2][2],
                    smartDeviceName: mySmartDevices[2][0], iconPath: mySmartDevices[2][1],
                    onChanged: (value) => powerSwitchChanged(value, 2),
                  ),
                  SmartDeviceAnimation(
                    isOn: mySmartDevices[1][2],
                    smartDeviceName: mySmartDevices[1][0], iconPath: mySmartDevices[1][1],
                    onChanged: (value) => powerSwitchChanged(value, 1),
                  ),
                  SmartLightAnimation(
                    isOn: mySmartDevices[0][2],
                    smartDeviceName: mySmartDevices[0][0], iconPath: mySmartDevices[0][1],
                    onChanged: (value) => powerSwitchChanged(value, 0),
                  ),

                ],
              ),

            )
          ],
        ),
      ),
    );
  }
}


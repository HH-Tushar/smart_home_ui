import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , Room Names ]
    [
      "Smart Light",
      "assets/light-bulb.png",
      ["BedRoom", "Living Room"],
      true
    ],
    [
      "Smart AC",
      "assets/air-conditioner.png",
      ["Bed Room"],
      false
    ],
    [
      "Smart TV",
      "assets/smart-tv.png",
      ["BedRoom", "Living Room"],
      false
    ],
    [
      "Smart Fan",
      "assets/fan.png",
      ["Bed Room"],
      true
    ],
  ];

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][3] = value;
    });
  }
  bool isAutoConnect=true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
                ],
              ),
              ListTile(
                enabled: true,
                selected: isAutoConnect,
                selectedColor: Colors.black,
               // tileColor: Colors.yellow,
               // selectedTileColor: Colors.green,
                title: const Text("Devices",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),),
                subtitle: const Text("Auto Connect",style: TextStyle(fontSize: 15),),
                trailing: CupertinoSwitch(
                  activeColor: Colors.grey.shade400,
                  trackColor: Colors.grey.shade200,
                  thumbColor: Colors.grey[850],
                  value: isAutoConnect,
                  onChanged: (value) {
                    isAutoConnect=value;
                    setState(() {

                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mySmartDevices.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: index == mySmartDevices.length - 1 ? 0 : 1,
                      child: RoomList(
                        deviceDetails: mySmartDevices[index],
                        onChanged: (value) => powerSwitchChanged(value, index),
                        isConnected: mySmartDevices[index][3],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RoomList extends StatelessWidget {
  final bool isConnected;
  final List deviceDetails;
  final Function(bool)? onChanged;
  const RoomList({
    super.key,
    required this.deviceDetails,
    required this.onChanged,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              deviceDetails[1],
              height: 50,
            ),
            Text(isConnected?deviceDetails[2].length.toString():""),
            const SizedBox(width: 70)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isConnected ? "Connected" : "Not Connected",style: const TextStyle(fontSize: 16),),
            Text(deviceDetails[0],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: deviceDetails[2].length,
                  itemBuilder: (_, index) => Card(
                        // margin: EdgeInsets.all(5),
                        color: Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            deviceDetails[2][index].toString(),
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )),
            ),
            const SizedBox(
              height: 5,
              width: 200,
            )
          ],
        ),
        SizedBox(
          width: 50,
          child: CupertinoSwitch(
              activeColor: Colors.grey.shade800,
              trackColor: Colors.grey.shade300,
              //thumbColor: Colors.grey[850],
              value: isConnected,
              onChanged: onChanged),
        )
      ],
    );
  }
}

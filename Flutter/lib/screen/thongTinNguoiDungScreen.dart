import 'package:flutter/material.dart';

class Thongtinnguoidungscreen extends StatefulWidget {
  @override
  State<Thongtinnguoidungscreen> createState() =>
      _ThongtinnguoidungscreenState();
}

class _ThongtinnguoidungscreenState extends State<Thongtinnguoidungscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Định dạng hình tròn
              image: DecorationImage(
                image: AssetImage('images/login.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "Nguyen Dinh Nhat Khoa",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "      Don mua",
              )),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [Icon(Icons.access_alarm), Text("cho xac nhan")],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                children: [Icon(Icons.access_alarm), Text("cho xac nhan")],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                children: [Icon(Icons.access_alarm), Text("cho xac nhan")],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                children: [Icon(Icons.access_alarm), Text("cho xac nhan")],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Text("Ho so"),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Text("Ho so"),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    Text("Cai Dat"),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.person),
                    Text("Trung tam tro giup"),
                  ],
                ),
              ),
              
            ],
          )
        ],
      ),
    ));
  }
}

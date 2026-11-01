import 'package:flutter/material.dart';
import 'package:uber/core/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myBlack,
      child: ListView(
        children: const [
          SizedBox(height: 20),
          Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Ride'),
              subtitle: Text('Request a ride'),
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Ride'),
              subtitle: Text('Request a ride'),
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Ride'),
              subtitle: Text('Request a ride'),
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Ride'),
              subtitle: Text('Request a ride'),
            ),
          ),
        ],
      ),
    );
  }
}

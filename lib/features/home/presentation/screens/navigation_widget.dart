import 'package:flutter/material.dart';
import 'package:uber/core/constants/colors.dart';
import 'package:uber/core/widgets/bottom_nav_bar.dart';
import 'package:uber/features/home/presentation/screens/home_screen.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const Center(child: HomeScreen()),
    const Center(child: Text('Explore Screen')),
    const Center(child: Text('Activity Screen')),
    const Center(child: Text('Account Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: myBlack,
      body: screens[currentIndex],

      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

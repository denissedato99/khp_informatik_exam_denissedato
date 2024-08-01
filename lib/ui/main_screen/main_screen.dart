import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../calendar/calendar_screen.dart';
import '../camera/camera_screen.dart';
import '../camera/camera_view_model.dart';
import '../gallery/gallery_screen.dart';
import '../home/home_screen.dart';
import 'main_screen_view_model.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  const MainScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const GalleryScreen(),
    const CalendarScreen(),
    ChangeNotifierProvider(
      create: (context) => CameraViewModel(),
      child: const CameraScreen(),
    ),
  ];

  void onItemTapped(int index) {
    // Switch tab
    final mainScreenViewModel = context.read<MainScreenViewModel>();
    mainScreenViewModel.setBottomNavTabIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    final mainScreenViewModel = context.watch<MainScreenViewModel>();

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedLabelStyle: Theme.of(context).textTheme.labelMedium,
          unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.photo,
              ),
              activeIcon: Icon(
                Icons.photo,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Gallery',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.calendar_view_day,
              ),
              activeIcon: Icon(
                Icons.calendar_view_day,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Calender',
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.camera,
              ),
              activeIcon: Icon(
                Icons.camera,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: 'Camera',
            ),
          ],
          currentIndex: mainScreenViewModel.bottomTabIndex,
          onTap: onItemTapped,
        ),
        body: _widgetOptions.elementAt(mainScreenViewModel.bottomTabIndex));
  }
}

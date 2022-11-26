import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';
import 'package:zoom_clone/screens/history_meeting_screen.dart';
import 'package:zoom_clone/screens/meeting_screen.dart';
import 'package:zoom_clone/screens/settings_screen.dart';
import 'package:zoom_clone/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  bool showFab = false;
  int _page = 1;

  onPageChanged(int page) {
    _page = page;
    page == 0 ? showFab = true : showFab = false;
    setState(() {});
  }

  List<Widget> pages = [
    const HistoryMeetingScreen(),
    MeetingScreen(),
    const SettingsScreen(),
    // CustomButton(text: 'Logout', press: () => AuthMethods().logout())
  ];
  void _wipeFirestoreMeetingData() {
    _firestoreMethods.wipeMeetingHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Zed Clone"),
        backgroundColor: bgColor,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        // unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: showFab,
        child: FloatingActionButton(
          backgroundColor: bgColor,
          onPressed: wipeMeetingHistory,
          child: const Icon(
            Icons.delete_forever,
            size: 30,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Future<void> wipeMeetingHistory() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wipe Meeting History 🗑'),
          content: const Text(
              'You are about to wipe your entire meeting history, this action is irreversible.'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
            ),
            TextButton(
              child: const Text(
                'Wipe Data',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _wipeFirestoreMeetingData();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

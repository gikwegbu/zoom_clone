import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/screens/video_call_screen.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

class MeetingScreen extends StatefulWidget {
  MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  final JistsiMeetMethods _jistsiMeetMethods = JistsiMeetMethods();
  String meetingSubject = '';

  void createNewMeeting() async {
    var rand = Random();
    String roomName = (rand.nextInt(10000000) + 10000000).toString();
    // This or, pop up a modal, to allow the creator add the name of the Room
    _jistsiMeetMethods.createMeeting(
      roomName: roomName,
      isAudioMuted: true,
      isVideoMuted: true,
      meetingSubject: meetingSubject,
    );
  }

  void joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, VideoCallScreen.routeName);
  }

  Future<void> setMeetingSubject() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Meeting Subject'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                meetingSubject = value;
              });
            },
            decoration:
                const InputDecoration(hintText: "What's the meeting about?"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                createNewMeeting();
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Lottie.asset(
              'assets/animations/meeting.json',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              // onPressed: createNewMeeting,
              onPressed: setMeetingSubject,
              icon: Icons.videocam,
              text: "New Meeting",
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              icon: Icons.add_box_rounded,
              text: "Join Meeting",
            ),
          ],
        ),
      ],
    );
  }
}

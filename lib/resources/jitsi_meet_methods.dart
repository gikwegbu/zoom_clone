import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class JistsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    required String meetingSubject,
    String username = '',
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;

      var options = JitsiMeetingOptions(room: roomName)
        ..serverURL = "https://meet.jit.si/"
        ..subject = meetingSubject
        // ..userDisplayName = _authMethods.user.displayName
        ..userDisplayName =
            username.isEmpty ? _authMethods.user.displayName : username
        ..userEmail = _authMethods.user.email
        ..userAvatarURL = _authMethods.user.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      debugPrint("JitsiMeetingOptions: $options");
      _firestoreMethods.addtomeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

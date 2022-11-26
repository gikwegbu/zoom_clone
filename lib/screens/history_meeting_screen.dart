import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingsHistory,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if ((snapshot.data! as dynamic).docs.length == 0) {
          return Column(
            children: [
              Container(
                child: Lottie.asset(
                  'assets/animations/empty.json',
                  fit: BoxFit.cover,
                ),
              ),
              const Center(
                child: Text("Meeting info will be kept here for you 🙃."),
              ),
            ],
          );
        }

        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Room Topic: ${(snapshot.data! as dynamic).docs[index]['meetingSubject']}",
                    ),
                    Text(
                      "Room ID: ${(snapshot.data! as dynamic).docs[index]['meetingName']}",
                    ),
                  ],
                ),
                subtitle: Text(
                    "Joined on ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}"),
              ),
            ),
          ),
        );
      }),
    );
  }
}

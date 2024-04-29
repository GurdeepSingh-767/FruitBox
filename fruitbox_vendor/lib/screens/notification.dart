import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notification_View extends StatelessWidget {
  const Notification_View({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          Positioned.fill(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return listView(snapshot.data!.docs);
                },
              ),)
        ],
      )

    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        'Notification Received',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Color(0xFFFFC201),
    );
  }

  Widget listView(List<QueryDocumentSnapshot> documents) {
    return ListView.separated(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        return listViewItem(documents[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 0,
        );
      },
    );
  }

  Widget listViewItem(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(data['message']),
                  timeAndDate(data['timestamp']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Icon(
        Icons.notifications,
        size: 25,
        color: Colors.red,
      ),
    );
  }

  Widget message(String message) {
    double textSize = 14;

    return Container(
      child: RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: 'Message: ',
          style: TextStyle(
            fontSize: textSize,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: message,
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeAndDate(Timestamp timestamp) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            timestamp.toDate().toString(),
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:beauty_center/canceled_page.dart';
import 'package:beauty_center/completed_page.dart';
import 'package:beauty_center/upcoming_page.dart';
import 'package:flutter/material.dart';

class SBookingPage extends StatelessWidget {
  const SBookingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal[700],
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              'Booking',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
              color: Colors.black,
              iconSize: 30.0,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: AppBar(
                      bottom: const TabBar(
                        tabs: [
                          Tab(
                            text: 'Upcoming',
                          ),
                          Tab(
                            text: 'Completed',
                          ),
                          Tab(
                            text: 'Cancelled',
                          ),
                        ],
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                        unselectedLabelStyle:
                            TextStyle(fontSize: 16, color: Colors.grey),
                        indicatorColor: Colors.teal,
                        indicatorWeight: 4.0,
                      ),
                    ),
                    body: const TabBarView(
                      children: [
                        SUpcomingPage(),
                        SCompletedPage(),
                        SCanceledPage(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

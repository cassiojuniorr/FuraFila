import 'package:flutter/material.dart';
import './profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          "FuraFila",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(46, 10, 96, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              icon: const Icon(Icons.account_circle_rounded)),
        ],
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(46, 10, 96, 1),
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.home),
                  Text(
                    'Home',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  )
                ],
              ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
            )
          ],
        ),
      ),
      body: const Stack(
        children: [
          Text(
            "Principal",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

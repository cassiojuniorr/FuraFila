import 'package:flutter/material.dart';

class Exec extends StatelessWidget {
  const Exec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Puxada Alata Pronada - Treino A"),),
        drawer: const Drawer(),
        floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add),),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Icon(Icons.send)),
              const Text("Como fazer?", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red), ),
              const Divider(),
            ],
          ),
        ),
    );
  }
}
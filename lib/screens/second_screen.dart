import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.email, required this.password});
  final String email;
  final String password;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Email: ${widget.email}'),
            const SizedBox(height: 8,),
            Text('Pass: ${widget.password}'),
            const SizedBox(height: 8,),
            Text('Name: ${widget.email}'),
            const SizedBox(height: 8,),
            Text('Phone: ${widget.email}'),
            const SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}

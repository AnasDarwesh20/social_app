import 'package:flutter/material.dart';

class AddStoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children: [
              Text('add story') ,
            ],
          ),
        ),
      ),
    );
  }
}

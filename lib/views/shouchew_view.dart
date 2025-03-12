import 'package:flutter/material.dart';

class ShouchewView extends StatefulWidget {
  final index;
  const ShouchewView({super.key, required this.index});

  @override
  State<ShouchewView> createState() => _ShouchewViewState();
}

class _ShouchewViewState extends State<ShouchewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shou Chew'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: ()=> print('tap'),
                child: Image.asset('assets/images/shou2.jpg')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Shou Zi Chew',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Audiowide')),
                Icon(Icons.phone_android),
              ],
            ),
            Text('CEO of Tiktok')
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us',          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.black,),
        ),
      ),
      body:  Center(
        child: Column(
          children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/logo.jpg',height: 400,width: 400,
                ),
              ),

            
            const Text(
              'This is the About Us page.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text(
              'A restaurant mobile app is an application dedicated to a specific restaurant concept or chain of restaurants. Whether you own an Android or an iPhone, you use mobile apps on your phone every day. ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );

  }
}

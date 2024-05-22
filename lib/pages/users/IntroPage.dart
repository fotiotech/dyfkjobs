import 'package:flutter/material.dart';
import 'completeabout.dart'; // Ensure this is the correct path to your form page

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'How to Complete the Form',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This form is divided into three steps. You will be asked to provide the following information:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Personal Information: Name, Location, Bio, and Profile Picture.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '2. Professional Information: Skills, Experience, Education, and Linked Accounts.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '3. Job Details: Job Posts and additional information.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Click the button below to start the form. You can navigate between steps and your progress will be indicated by the progress bar at the top.',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompleteAbout()),
                  );
                },
                child: const Text('Start the Form'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

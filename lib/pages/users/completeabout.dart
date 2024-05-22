import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompleteAbout extends StatefulWidget {
  const CompleteAbout({super.key});

  @override
  State<CompleteAbout> createState() => _CompleteAboutState();
}

class _CompleteAboutState extends State<CompleteAbout> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _linkAccountController = TextEditingController();
  final TextEditingController _jobPostController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  Future<void> handleCompleteAboutForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseFirestore.instance
            .collection('dyfdlindb')
            .doc(user?.uid)
            .set({
          'name': _nameController.text,
          'location': _locationController.text,
          'bio': _bioController.text,
          'skill': _skillController.text,
          'experience': _experienceController.text,
          'education': _educationController.text,
          'linkAccount': _linkAccountController.text,
          'jobPost': _jobPostController.text,
          // Add more fields as needed
        });

        print('Submitted in Successful!');
        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        print(e.toString());
      }
    }
  }

  int _currentStep = 0;

  void _nextStep() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_currentStep < 2) {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
        setState(() {
          _currentStep++;
        });
      } else {
        handleCompleteAboutForm(context);
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentStep + 1) / 3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    _buildStep1(),
                    _buildStep2(),
                    _buildStep3(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: _previousStep,
                      child: const Text('Previous'),
                    ),
                  ElevatedButton(
                    onPressed: _nextStep,
                    child: Text(_currentStep < 2 ? 'Next' : 'Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return ListView(
      children: <Widget>[
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _locationController,
          decoration: const InputDecoration(labelText: 'Location'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your location';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _bioController,
          decoration: const InputDecoration(labelText: 'Bio'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your bio';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _profilePictureController,
          decoration: const InputDecoration(labelText: 'Profile Picture'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your profile picture URL';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return ListView(
      children: <Widget>[
        TextFormField(
          controller: _skillController,
          decoration: const InputDecoration(labelText: 'Skills'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your skills';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _experienceController,
          decoration: const InputDecoration(labelText: 'Experience'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your experience';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _educationController,
          decoration: const InputDecoration(labelText: 'Education'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your education';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _linkAccountController,
          decoration: const InputDecoration(labelText: 'Linked Accounts'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your linked accounts';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return ListView(
      children: <Widget>[
        TextFormField(
          controller: _jobPostController,
          decoration: const InputDecoration(labelText: 'Job Posts'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your job posts';
            }
            return null;
          },
        ),
        // Add more fields as needed
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController requirementController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController applicationsController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  void addJob() {
    try {
      FirebaseFirestore.instance.collection('jobs').add({
        'id': user?.uid ?? '',
        'title': titleController.text,
        'description': descriptionController.text,
        'location': locationController.text,
        'type': typeController.text,
        'salary': salaryController.text,
        'requirement': requirementController.text,
        'deadline': deadlineController.text,
        'status': statusController.text,
      }).then((value) {
        print("Job Posted: $value");
      }).catchError((error) {
        print("Failed to post job: $error");
      });
    } catch (e) {
      print("Error picking file: $e");
    }
    // pickFile();
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        String? filePath = result.files.single.path;
        setState(() {
          _imageController.text = filePath!;
        });

        // Create the file metadata
        final metadata =
            SettableMetadata(contentType: "image/jpeg", customMetadata: {
          'id': user?.uid ?? '',
          'timestamp': DateTime.now().toIso8601String(),
        });

        // Create a reference to the Firebase Storage bucket
        final storageRef = FirebaseStorage.instance.ref();

        // Upload file and metadata to the path 'images/mountains.jpg'
        final file = File(filePath!);
        final uploadTask = storageRef.child("images/").putFile(file, metadata);

        // Listen for state changes, errors, and completion of the upload.
        uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              final progress = 100.0 *
                  (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
              print("Upload is $progress% complete.");
              break;
            case TaskState.paused:
              print("Upload is paused.");
              break;
            case TaskState.canceled:
              print("Upload was canceled");
              break;
            case TaskState.error:
              // Handle unsuccessful uploads
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Upload Error"),
                    content:
                        const Text("Failed to upload image. Please try again."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
              break;
            case TaskState.success:
              // Handle successful uploads on complete
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Uploaded successfully!"),
                    content: const Text("successfully uploaded image."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
              break;
          }
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print("Error picking file: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Failed to pick file. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),

              // Other form fields...
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: locationController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: salaryController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Salary'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: requirementController,
                decoration: const InputDecoration(labelText: 'Requirements'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: deadlineController,
                decoration: const InputDecoration(labelText: 'Deadline'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: applicationsController,
                decoration: const InputDecoration(labelText: 'Applications'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill this field!';
                  }
                  return null;
                },
              ),
              // Other form fields...
              TextFormField(
                controller: _imageController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Image',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: pickFile,
                  ),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please select an image';
                //   }
                //   return null;
                // },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                  ),
                  onPressed: () {
                    addJob();
                  },
                  child: const Text('Add Job'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    typeController.dispose();
    salaryController.dispose();
    requirementController.dispose();
    deadlineController.dispose();
    statusController.dispose();
    applicationsController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}

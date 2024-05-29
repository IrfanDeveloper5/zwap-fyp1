import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwap_fyp1/Models/postsModel.dart';
import 'package:zwap_fyp1/Raff-Screen/streamScreen.dart';
import 'package:zwap_fyp1/chats/api/apis.dart';
import 'package:zwap_fyp1/screens/HomeScreenCard.dart';
import 'package:zwap_fyp1/view/HomeScreen.dart';
import '../chats/models/chat_user.dart';

class PostScreenUser extends StatefulWidget {
  @override
  _PostScreenUserState createState() => _PostScreenUserState();
}

class _PostScreenUserState extends State<PostScreenUser> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _conditionController = TextEditingController();
  late final ChatUser chatUser;
  final _formKey = GlobalKey<FormState>();
  List<String> items = [
    'Electronics',
    'Clothing',
    'Furniture',
    'Books',
    'Accessories',
    'Toys',
    'Cars',
    'Real Estate',
    'Others'
  ];
  List<String> type = [
    'Swapping',
    'Donations',
    'Re-Cycle'
  ];
  List<String> selectedItems = [];
  String? selectedType;
  List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *',
                  hintText: 'Enter title...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Upload Pictures/Videos'),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: _images.map((image) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        File(image.path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _images.remove(image);
                          });
                        },
                        icon: const Icon(Icons.close, color: Colors.red),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Write a description...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location *',
                  hintText: 'Enter location...',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Condition',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _conditionController,
                decoration: const InputDecoration(
                  labelText: 'Condition *',
                  hintText: 'NEW, LIKE NEW, GOOD...',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a condition';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Items'),
                value: selectedItems.isNotEmpty ? selectedItems[0] : null,
                onChanged: (String? newValue) {
                  setState(() {
                    if (selectedItems.contains(newValue)) {
                      selectedItems.remove(newValue);
                    } else {
                      selectedItems.add(newValue!);
                    }
                  });
                },
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 36,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Text('Selected Items: ${selectedItems.join(", ")}'),
              const SizedBox(height: 10),
              const Text(
                'Types',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Type'),
                value: selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedType = newValue;
                  });
                },
                items: type.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 36,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Text('Selected Type: $selectedType'),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_images.isNotEmpty) {
                      _validateAndPostData();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please upload at least one image'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('Post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
    if (images != null && images.isNotEmpty) {
      setState(() {
        _images.addAll(images);
      });
    }
  }

  Future<void> _postDataToFirestore() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String title = _titleController.text;
    String description = _descriptionController.text;
    String location = _locationController.text;
    String condition = _conditionController.text;
    List<String> selectedItems = this.selectedItems;
    String? selectedType = this.selectedType;

    List<String> imageUrls = [];
    for (var image in _images) {
      try {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('Post_images/${DateTime.now()}.jpg');
        await ref.putFile(File(image.path));
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      } catch (e) {
        print('Error uploading image to Firebase Storage: $e');
      }
    }

    try {
      // if (selectedType == 'Donations') {
      //   await FirebaseFirestore.instance.collection('posts/donations').add({
      //     'title': title,
      //     'description': description,
      //     'location': location,
      //     'items': selectedItems,
      //     'condition': condition,
      //     'types': selectedType,
      //     'imageUrls': imageUrls,
      //     'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
      //     'userId': chatUser.id,
      //   });
      // } else if (selectedType == 'Swapping') {
      //   await FirebaseFirestore.instance.collection('posts/swapping').add({
      //     'title': title,
      //     'description': description,
      //     'location': location,
      //     'items': selectedItems,
      //     'condition': condition,
      //     'types': selectedType,
      //     'imageUrls': imageUrls,
      //     'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
      //     'userId': chatUser.id,
      //   });
      // } else if (selectedType == 'Re-Cycle') {
      //   await FirebaseFirestore.instance.collection('posts/re-cycle').add({
      //     'title': title,
      //     'description': description,
      //     'location': location,
      //     'items': selectedItems,
      //     'condition': condition,
      //     'types': selectedType,
      //     'imageUrls': imageUrls,
      //     'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
      //     'userId': chatUser.id,
      //   });
      // }
       await FirebaseFirestore.instance.collection('posts').add({
          'title': title,
          'description': description,
          'location': location,
          'items': selectedItems,
          'condition': condition,
          'types': selectedType,
          'imageUrls': imageUrls,
          'timestamp': DateTime.now().microsecondsSinceEpoch.toString(),
          'userId': chatUser.id,
        });

      _titleController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _conditionController.clear();
      this.selectedItems.clear();
      selectedType = null;
      _images.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post added successfully')),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomeScreenMain(user: APIs.me)));
    } catch (e) {
      print('Error adding post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error adding post')),
      );
    }
  }

  void _validateAndPostData() async {
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload at least one image')),
      );
    } else {
      await _postDataToFirestore();
    }
  }
}

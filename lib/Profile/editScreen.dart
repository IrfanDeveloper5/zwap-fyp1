import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../chats/api/apis.dart';
import '../chats/helper/dialogs.dart';
import '../chats/models/chat_user.dart';

class EditScreen extends StatefulWidget {
  final ChatUser user;
  const EditScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User profile picture
                Stack(
                  children: [
                    // Profile picture
                    Center(child: _buildProfilePicture(screenWidth)),

                    // Edit image button
                    Positioned(
                      bottom: screenHeight * 0.02,
                      right: screenWidth * 0.15,
                      child: MaterialButton(
                        elevation: 1,
                        onPressed: () {
                          _showBottomSheet();
                        },
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: const Icon(Icons.edit, color: Colors.blue),
                      ),
                    ),
                  ],
                ),

                // Add some space
                SizedBox(height: screenHeight * 0.03),

                // Name text field
                TextFormField(
                  initialValue: widget.user.name,
                  onSaved: (val) => APIs.me.name = val ?? '',
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Required Field',
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.06),
                    ),
                    hintText: 'eg. Irfan Munawar',
                    labelText: 'Name',
                  ),
                ),

                // Add some space
                SizedBox(height: screenHeight * 0.03),

                // About text field
                TextFormField(
                  initialValue: widget.user.about,
                  onSaved: (val) => APIs.me.about = val ?? '',
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : 'Required Field',
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.info_outline, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.06),
                    ),
                    hintText: 'eg. Feeling Happy',
                    labelText: 'About',
                  ),
                ),


                // Add some space
                SizedBox(height: screenHeight * 0.03),

                // Update profile button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(
                            context,
                            'Profile Updated Successfully!',
                          );
                        });
                      }
                    },
                    icon: const Icon(Icons.edit, size: 28),
                    label: const Text(
                      'UPDATE',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size(screenWidth * 0.25, screenHeight * 0.03),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget to display the profile picture
  Widget _buildProfilePicture(double screenWidth) {
    return _image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.06),
            child: Image.file(
              File(_image!),
              width: screenWidth * 0.50,
              height: screenWidth * 0.50,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.23),
            child: CachedNetworkImage(
              width: screenWidth * 0.50,
              height: screenWidth * 0.50,
              fit: BoxFit.cover,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) => const CircleAvatar(
                child: Icon(CupertinoIcons.person),
              ),
            ),
          );
  }

  // Bottom sheet for picking a profile picture for the user
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          children: [
            const Text(
              'Pick Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      setState(() {
                        _image = image.path;
                      });
                      APIs.updateProfilePicture(File(_image!));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Pick from Gallery'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                    );
                    if (image != null) {
                      setState(() {
                        _image = image.path;
                      });
                      APIs.updateProfilePicture(File(_image!));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Take Picture'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

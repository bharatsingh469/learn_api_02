import 'dart:typed_data';

import 'package:api_flutter_1/api_service/upload_image_apis.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  String uploadImage = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        
        child: isLoading? const CircularProgressIndicator(): 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            uploadImage == ""
                ? const SizedBox()
                : Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: NetworkImage(uploadImage))),
                  ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                // Pick an image.
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    isLoading = true;
                  });

                  Uint8List bytes = await image.readAsBytes();

                  ApiServices().uploadImage(bytes, image.name).then((value) {
                    print('Image upload ho gyi bro ......');
                    print("Response ${value.toString()} ");

                    setState(() {
                      uploadImage = value['location'].toString();
                      isLoading = false;
                    });
                  }).onError((error, stackTrace) {
                    print('Error on uploadingg hj i');
                    print(error.toString());
                    setState(() {
                      isLoading = false;
                    });
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Upload image'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

class ReportWastePage extends StatefulWidget {
  @override
  _ReportWastePageState createState() => _ReportWastePageState();
}

class _ReportWastePageState extends State<ReportWastePage> {
  final TextEditingController _description = TextEditingController();
  File? imageFile;
  Position? position;

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => imageFile = File(picked.path));
    }
  }

  Future getLocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {});
  }

  Future uploadReport() async {
    String imageUrl = "";
    if (imageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child("waste_images/${DateTime.now()}.jpg");
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
    }

    await FirebaseFirestore.instance.collection("reports").add({
      "description": _description.text,
      "latitude": position?.latitude,
      "longitude": position?.longitude,
      "image": imageUrl,
      "date": DateTime.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Report Submitted Successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report Waste")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _description,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Describe the waste issue",
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Take Photo"),
              onPressed: pickImage,
            ),
            imageFile != null ? Image.file(imageFile!) : SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Get Location"),
              onPressed: getLocation,
            ),
            position != null
                ? Text(
                    "Location: ${position!.latitude}, ${position!.longitude}")
                : SizedBox(),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Submit Report"),
              onPressed: uploadReport,
            ),
          ],
        ),
      ),
    );
  }
}

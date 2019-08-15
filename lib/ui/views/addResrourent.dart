import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:resturent_app/core/models/RestauranttModel.dart';
import 'package:resturent_app/core/viewmodels/CRUDModel.dart';

class AddResrourent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddResrourentState();
  }
}

class _AddResrourentState extends State<AddResrourent> {
  TextEditingController fansController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  File _imageFile;
  String imageDowenloadUrl = "";
  bool loading = false;

  void _getImage(BuildContext context, ImageSource source) async {
    ImagePicker.pickImage(
      source: source,
      maxHeight: 400.0,
    ).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    }).catchError((onError) {});
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 160,
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Text("Pick an Image"),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Text("Use Camera"),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  child: Text("Use Gallery"),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((value) {
      setState(() {
        imageDowenloadUrl = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final restourentProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add restourent"),
      ),
      body: Container(
        child: loading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextField(
                      controller: fansController,
                      decoration: InputDecoration(hintText: "Fans"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    OutlineButton(
                      onPressed: () {
                        _openImagePicker(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.camera_alt),
                          SizedBox(
                            width: 30,
                          ),
                          Text("Add Photo"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _imageFile == null
                        ? Text("please pick an Image")
                        : Image.file(
                            _imageFile,
                            fit: BoxFit.cover,
                            height: 300,
                            alignment: Alignment.topCenter,
                          ),
                    FlatButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        await uploadPic(context);


                        restourentProvider.addProduct(Restaurant(
                          name: nameController.text.toString(),
                          fans: fansController.text.toString(),
                          img: imageDowenloadUrl.toString(),
                          menu: [],
                        ));

                        setState(() {
                          loading = false;
                          Navigator.pop(context);
                        });
                      },
                      child: Center(
                        child: Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

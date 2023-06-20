import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'watermarker.dart';

class ImageCropScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ImageSropScreenState();
  }

}

class _ImageSropScreenState extends State<ImageCropScreen>{
  final ImagePicker _picker = ImagePicker();
  String WaterMark = "aaaa";
  File? _image;
  // final cropKey = GlobalKey<CropState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片处理"),
      ),
      body:Column(
          children: [
            Container(
              child: _image == null? Text("请选择图片"):
                  Image.file(_image!,width: 200,height: 200,),
              ),
            // Container(
            //   width: 400,height: 400,
            //   // child: Crop.file(_image!,key: cropKey),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed:(){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>WaterMarkerScreen()));
                  }, child: Text("选择水印")
                ),
                Text("水印:" + WaterMark),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){
                    pickImage();
                  }, child: Text("选择图片")
                ),
                ElevatedButton(
                  //     onPressed: (){
                  //   cropImage();
                  //
                  // },
                  onPressed: () {  },
                  child: Text("图片裁剪")
                ),
                ElevatedButton(onPressed: (){
                  // addWater();
                  imageAddWaterMark(_image!.path,"aaaa").then((value){
                    setState(() {
                      _image = value;
                    });
                  });

                  }, child: Text("添加水印")
                )
              ],
            ),
          ],
        ),
    );
  }


  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      _image = File(pickedFile!.path);
    });
  }


  // void cropImage()async{
  //   final scale = cropKey.currentState?.scale;
  //   final area = cropKey.currentState?.area;
  //
  //   final sampledFile = await ImageCrop.sampleImage(
  //     file: _image!,
  //     preferredWidth: (1024 / scale!).round(),
  //     preferredHeight: (4096 / scale).round(),
  //   );
  //
  //   final croppedFile = await ImageCrop.cropImage(
  //     file: sampledFile,
  //     area:area!,
  //   );
  //
  //   setState(() {
  //
  //     _image = croppedFile;
  //   });
  //
  //
  // }



}
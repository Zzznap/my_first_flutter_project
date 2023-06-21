import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/cascadingPicker.dart';
import 'watermarker.dart';

class ImageCropScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ImageSropScreenState();
  }

}

class _ImageSropScreenState extends State<ImageCropScreen>{
  final ImagePicker _picker = ImagePicker();
  String defaultWaterMark = "aaaa";
  List<String> selectedWaterMark = [];
  File? _imageView;
  File? _imageOrigin;

  // final cropKey = GlobalKey<CropState>();
  void getSelect(List<String> newSelectedWaterMark) {
    setState(() {
      selectedWaterMark = newSelectedWaterMark;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片处理"),
      ),
      body:Column(
          children: [
            Container(
              child: _imageOrigin == null? Text("请选择图片"):
                  Image.file(_imageView!,width: 200,height: 200,),

              ),
            // Container(
            //   width: 400,height: 400,
            //   // child: Crop.file(_image!,key: cropKey),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              //   ElevatedButton(onPressed:(){
              //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>WaterMarkerScreen()));
              //     }, child: Text("选择水印")
              //   ),
              //   Text("水印:" + WaterMark),
              // ],
                Container(
                  child:  SizedBox(
                    width: 100,
                    child: CascadingDropdown(callback: getSelect,),)
                ),
                Container(
                  child:SizedBox(
                    width: 100,
                    child: Text("水印:" + selectedWaterMark.join(',')),)
                ),
              ]
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
                  onPressed: () {
                    if(_imageOrigin == null){
                      PictureNull();
                      return;
                    }
                  },
                  child: Text("图片裁剪")
                ),
                ElevatedButton(onPressed: (){
                  // addWater();
                  if(_imageOrigin == null){
                    PictureNull();
                    return;
                  }
                  _imageView = _imageOrigin;
                  imageAddWaterMark(_imageView!.path,selectedWaterMark.isNotEmpty ?selectedWaterMark.join(','):defaultWaterMark).then((value){
                    setState(() {
                      _imageView = value;
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
  void PictureNull() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("提示"),
        content: Text("请先选择图片"),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("确定"))
        ],
      );
    });
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    setState(() {
      _imageOrigin = File(pickedFile!.path);
      _imageView = _imageOrigin;
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
void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: ImageCropScreen(),
  ));
}
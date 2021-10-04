
import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageModel {

  String fileName;
  String createdDate;
  String filePath;

  ImageModel({this.fileName = 'TYT_19 CozKazan(5li) M', this.createdDate = 'Febrary 3, 8:00 AM', this.filePath = ''});
}

class ImageCellUI extends StatelessWidget {
  ImageCellUI(this.imageModel, this.onClickCallback);
  Function onClickCallback;
  ImageModel imageModel;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        onClickCallback();
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: EdgeInsets.only(top: 12, left: 4, right: 4),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color(0xffe8e9ec),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(2, 2),
                  blurRadius: 1.5
              )
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8,right: 12),
              child: Image.asset('assets/images/ic_pdf.png',width: 48,height: 48,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  imageModel.fileName + '_',
                  style: abelStyleNormal().copyWith(color: kMainTextColor, fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                  child: Text(imageModel.createdDate,
                    style: abelStyleNormal().copyWith(color: kLightTextColor, fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8,),
                      child: Image.asset('assets/images/ic_tag.png',width: 18,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                      child: Text('Biology',
                        style: abelStyleNormal().copyWith(color: kLightTextColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ImageSelectCellUI extends StatelessWidget {
  ImageSelectCellUI(this.imageModel, this.chk, this.onClickCallback, this.changeCheck);
  Function onClickCallback;
  Function changeCheck;
  ImageModel imageModel;
  bool chk = false;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        onClickCallback();
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: EdgeInsets.only(top: 12, left: 4, right: 4),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color(0xffe8e9ec),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(2, 2),
                  blurRadius: 1.5
              )
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8,right: 12),
              child: Image.asset('assets/images/ic_pdf.png',width: 48,height: 48,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  imageModel.fileName + '_',
                  style: abelStyleNormal().copyWith(color: kMainTextColor, fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                  child: Text(imageModel.createdDate,
                    style: abelStyleNormal().copyWith(color: kLightTextColor, fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8,),
                      child: Image.asset('assets/images/ic_tag.png',width: 18,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                      child: Text('Biology',
                        style: abelStyleNormal().copyWith(color: kLightTextColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Spacer(),
            
            Padding(
              padding: EdgeInsets.all(12),
              child: InkWell(
                child: Icon(Icons.check_box, color: chk ? kMainTextColor : Colors.grey,),
                onTap: (){
                  chk = !chk;
                  changeCheck(chk);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
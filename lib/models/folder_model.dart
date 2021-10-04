
import 'package:filemanagerdx/models/image_model.dart';
import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:filemanagerdx/utils/utils_app.dart';
import 'package:filemanagerdx/utils/utils_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderModel {

  String folderName;
  String createdDate;
  String filePath;
  List<ImageModel> images;

  FolderModel({this.folderName = 'Folder', this.createdDate = 'Febrary 3, 8:00 AM', this.images, this.filePath = ''});
}

class FolderCellUI extends StatelessWidget {
  FolderCellUI(this.folderIndex, this.clickCallback);
  int folderIndex;
  Function clickCallback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        clickCallback(FOLDER_CELL, 0);
      },
      child: Container(
        width: double.infinity, height: 80,
        margin: EdgeInsets.only(top: 12, left: 4, right: 4),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: kCellColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: Offset(2, 2),
                  blurRadius: 1.5
              )
            ]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Image.asset('assets/images/ic_folder.png', width: 42,height: 42,),
            ),
            Container(
              margin: EdgeInsets.only(left: 14),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        folders.elementAt(folderIndex).folderName.length <= 20 ? folders.elementAt(folderIndex).folderName : folders.elementAt(folderIndex).folderName.substring(0, 20),
                        style: gilroyStyleMedium().copyWith(
                          color: kMainTextColor,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(6, 6, 0, 0),
                        child: Text(
                          folders.elementAt(folderIndex).createdDate.length <= 20 ? folders.elementAt(folderIndex).createdDate : folders.elementAt(folderIndex).createdDate.substring(0, 24),
                          style: gilroyStyleRegular().copyWith(color: kLightTextColor, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 6,),
              child: Container(
                width: 32,height: 32,
                decoration: BoxDecoration(
                  border: Border.all(color: kHintColor),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Center(
                  child: Text(
                    folders.elementAt(folderIndex).images.length.toString(),
                    style: abelStyleNormal().copyWith(color: kLightTextColor, fontSize: 16,),
                  ),
                ),
              ),
            ),
            Container(
              child: PopupMenuButton(
                  onSelected: (value) {
                    clickCallback(FOLDER_CELLMENU, value);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        value: RENAME,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
                              child: Image.asset('assets/images/ic_edit.png', width: 24, color: Colors.grey,),
                            ),
                            Text(appLocale.translate('rename'), style: abelStyleNormal().copyWith(color: Colors.grey, fontSize: 18),)
                          ],
                        )
                    ),
                    PopupMenuItem(
                        value: MOVE,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                              child: Image.asset('assets/images/ic_move.png', width: 24, color: Colors.grey,),
                            ),
                            Text(appLocale.translate('move'), style: abelStyleNormal().copyWith(color: Colors.grey, fontSize: 18),)
                          ],
                        )
                    ),
                    PopupMenuItem(
                        value: DELETE,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                              child: Image.asset('assets/images/ic_delete.png', width: 24, color: Colors.grey,),
                            ),
                            Text(appLocale.translate('delete'), style: abelStyleNormal().copyWith(color: Colors.grey, fontSize: 18),)
                          ],
                        )
                    ),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
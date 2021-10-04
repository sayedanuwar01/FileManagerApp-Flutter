import 'package:filemanagerdx/models/image_model.dart';
import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:filemanagerdx/utils/utils_app.dart';
import 'package:filemanagerdx/utils/utils_constants.dart';
import 'package:filemanagerdx/utils/utils_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagModel {

  String tagName;
  String createdDate;
  String rootPath;
  String horizontalLine;
  String verticalLine;
  List<ImageModel> images;

  TagModel({this.tagName = 'Folder', this.createdDate = 'Febrary 3, 8:00 AM', this.images, this.rootPath = '', this.horizontalLine = '', this.verticalLine = ''});
}

class TagCellUI extends StatelessWidget {
  TagCellUI(this.tagIndex, this.onClickCallback);
  int tagIndex;
  Function onClickCallback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClickCallback(TAGS_NAVIGATOR, 0);
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
              child: Image.asset('assets/images/ic_tag_white.png', width: 42,height: 42,),
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
                        tags.elementAt(tagIndex).tagName.length <= 20 ? tags.elementAt(tagIndex).tagName : tags.elementAt(tagIndex).tagName.substring(0, 20),
                        style: gilroyStyleMedium().copyWith(
                          color: kMainTextColor,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(6, 6, 0, 0),
                        child: Text(
                          tags.elementAt(tagIndex).createdDate.length <= 20 ? tags.elementAt(tagIndex).createdDate : tags.elementAt(tagIndex).createdDate.substring(0, 24),
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
                    tags.elementAt(tagIndex).images.length.toString(),
                    style: abelStyleNormal().copyWith(color: kLightTextColor, fontSize: 16,),
                  ),
                ),
              ),
            ),
            Container(
              child: PopupMenuButton(
                  onSelected: (value) {
                    onClickCallback(TAGS_MENU_CLICK, value);
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

class AddTagDialog extends StatefulWidget {
  AddTagDialog({this.callback});
  Function callback;

  @override
  State<StatefulWidget> createState() {
    return AddTagState();
  }
}

class AddTagState extends State<AddTagDialog>{
  TextEditingController tagTitle = new TextEditingController();

  List<String> horizontalList = [
    'Horizontal Line 1',
    'Horizontal Line 2',
  ];

  List<String> verticalList = [
    'Vertical Line 1',
    'Vertical Line 2',
  ];

  TagModel newTag = new TagModel(horizontalLine: 'Horizontal Line 1', verticalLine: 'Vertical Line 1');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        child: dialogContent(context),
      ),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      height: 363,
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 18),
                child: Center(
                    child: Text(appLocale.translate('addTag'),
                      style: gilroyStyleMedium().copyWith(fontSize: 24, color: kTextColor.withOpacity(0.9)),
                    )//
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    child: Container(
                      width: 36, height: 36,
                      child: Stack(
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Container(color: kCloseCircleBack, width: 36, height: 36,),
                            ),
                          ),
                          Center(child: Icon(Icons.close, size: 26, color: kTextInputBackColor.withOpacity(0.7),)),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                      widget.callback(false, newTag);
                    },
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 24),
                  height: 40,
                  child: Container(
                    margin: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 2),
                    child: TextField(
                      controller: tagTitle,
                      autofocus: false,
                      style: gilroyStyleRegular().copyWith(color: kTextColor, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: appLocale.translate('tagTitle'),
                        hintStyle: gilroyStyleRegular().copyWith(color: kLightTextColor, fontSize: 16),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: kWhiteColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: kWhiteColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: kIconColor),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 24),
                  height: 40,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: SizedBox(),
                    value: newTag.horizontalLine,
                    items: horizontalList.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          child: Text(value,
                            style: abelStyleNormal().copyWith(color: kTextColor, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectHorizontal(value);
                    },
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: kIconColor),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 24),
                  height: 40,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: SizedBox(),
                    value: newTag.verticalLine,
                    items: verticalList.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          child: Text(value,
                            style: abelStyleNormal().copyWith(color: kTextColor, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectVertical(value);
                    },
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: kIconColor),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),

                InkWell(
                  child: Container(
                    height: 48,
                    margin: EdgeInsets.only(top: 24.0, ),
                    child: Center(
                      child: Text(appLocale.translate('addTag'),
                        style: gilroyStyleMedium().copyWith(fontSize: 22, color: kWhiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      color: kGreenColor,
                    ),
                  ),
                  onTap:(){
                    makeNewTag(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  makeNewTag(context){
    if(tagTitle.text == ''){
      showToast(appLocale.translate('enterRename'));
    }else{
      List<ImageModel> images = [];
      newTag.tagName = tagTitle.text;
      newTag.createdDate = TimeUtil.getCurrentTime();
      newTag.images = images;
      Navigator.pop(context);
      widget.callback(true, newTag);
    }
  }

  void selectHorizontal(String value) {
    newTag.horizontalLine = value;
    setState(() {});
  }

  void selectVertical(String value) {
    newTag.verticalLine = value;
    setState((){});
  }
}

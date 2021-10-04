import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:filemanagerdx/utils/utils_app.dart';
import 'package:filemanagerdx/utils/utils_constants.dart';
import 'package:filemanagerdx/utils/utils_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PDFModel {

  String pdfName;
  String createdDate;
  String horizontalLine;
  String verticalLine;
  int pageCount;

  PDFModel({this.pdfName = 'TYT_19 CozKazan(5li) M', this.createdDate = 'Febrary 3, 8:00 AM', this.pageCount = 120, this.horizontalLine = '', this.verticalLine = ''});

  factory PDFModel.fromJson(Map<String, dynamic> json) {
    return PDFModel(
      pdfName: json["pdfName"],
      createdDate: json["createdDate"],
      horizontalLine: json["horizontalLine"],
      verticalLine: json["verticalLine"],
      pageCount: int.parse(json["pageCount"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pdfName": this.pdfName,
      "createdDate": this.createdDate,
      "horizontalLine": this.horizontalLine,
      "verticalLine": this.verticalLine,
      "pageCount": this.pageCount,
    };
  }
//

}

class PDFCellUI extends StatelessWidget {
  PDFCellUI(this.pdfIndex, this.onClickCallback);
  Function onClickCallback;
  int pdfIndex;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        onClickCallback(PDF_CELL);
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: EdgeInsets.only(top: 12, left: 4, right: 4),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Color(0xffe8e9ec),
            borderRadius: BorderRadius.all(Radius.circular(12))
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
                  pdfs.elementAt(pdfIndex).pdfName.length <= 26 ? pdfs.elementAt(pdfIndex).pdfName : pdfs.elementAt(pdfIndex).pdfName.substring(0, 26),
                  style: gilroyStyleMedium().copyWith(color: kMainTextColor, fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                  child: Text(
                    pdfs.elementAt(pdfIndex).createdDate.length <= 26 ? pdfs.elementAt(pdfIndex).createdDate : pdfs.elementAt(pdfIndex).createdDate.substring(0, 26),
                    style: abelStyleNormal().copyWith(color: kLightTextColor, fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8,),
                      child: InkWell(
                        onTap: (){
                          onClickCallback(PDF_CELL_DOWN);
                        },
                        child: Image.asset('assets/images/ic_download.png', width: 21, color: Colors.grey,)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12,),
                      child: InkWell(
                        onTap: (){
                          onClickCallback(PDF_CELL_EDIT);
                        },
                          child: Image.asset('assets/images/ic_edit.png', width: 20,)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12,),
                      child: InkWell(
                        onTap: (){
                          onClickCallback(PDF_CELL_DELETE);
                        },
                          child: Image.asset('assets/images/ic_delete.png', width: 20,)
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Container(
                width: 32,height: 32,
                decoration: BoxDecoration(
                  border: Border.all(color: kHintColor),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Center(
                  child: Text(
                    pdfs.elementAt(pdfIndex).pageCount.toString(),
                    style: abelStyleNormal().copyWith(
                      color: kLightTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPDFDialog extends StatefulWidget {
  AddPDFDialog({this.callback});
  Function callback;

  @override
  State<StatefulWidget> createState() {
    return AddPDFState();
  }
}

class AddPDFState extends State<AddPDFDialog>{
  TextEditingController pdfTitle = new TextEditingController();

  List<String> horizontalList = [
    'Horizontal Line 1',
    'Horizontal Line 2',
  ];

  List<String> verticalList = [
    'Vertical Line 1',
    'Vertical Line 2',
  ];

  PDFModel newPdf = new PDFModel(pdfName: 'New Pdf', horizontalLine: 'Horizontal Line 1', verticalLine: 'Vertical Line 1');

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
                    child: Text(appLocale.translate('createPDF'),
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
                      widget.callback(false, newPdf);
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
                      controller: pdfTitle,
                      autofocus: false,
                      style: gilroyStyleRegular().copyWith(color: kTextColor, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: appLocale.translate('pdfName'),
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
                    value: newPdf.horizontalLine,
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
                    value: newPdf.verticalLine,
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
                      child: Text(appLocale.translate('create'),
                        style: gilroyStyleMedium().copyWith(fontSize: 22, color: kWhiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      color: kMainTextColor,
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
    if(pdfTitle.text == ''){
      showToast(appLocale.translate('enterRename'));
    }else{
      newPdf.pdfName = pdfTitle.text;
      newPdf.createdDate = TimeUtil.getCurrentTime();
      Navigator.pop(context);
      widget.callback(true, newPdf);
    }
  }

  void selectHorizontal(String value) {
    newPdf.horizontalLine = value;
    setState(() {});
  }

  void selectVertical(String value) {
    newPdf.verticalLine = value;
    setState((){});
  }
}
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:filemanagerdx/helpers/filesystem_utils.dart';
import 'package:filemanagerdx/languages/lang_localization.dart';
import 'package:filemanagerdx/models/city_model.dart';
import 'package:filemanagerdx/models/folder_model.dart';
import 'package:filemanagerdx/models/image_model.dart';
import 'package:filemanagerdx/models/package_model.dart';
import 'package:filemanagerdx/models/pdf_model.dart';
import 'package:filemanagerdx/models/tag_model.dart';
import 'package:filemanagerdx/models/user_model.dart';
import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

AppLocalizations appLocale;

var appName = 'Soru Sakla';

var currentUser = new UserModel();
var regTempUser = new UserModel();
var packageModel = new PackageModel();

var phoneNumber = '';
var phoneNumber_otp_hint = '';

var homeSelIndex = 0;
var fromWhere = '';

var localStatus = false;

bool inboxFilter = true;
bool tagsFilter = true;

String currentFolderPath = '';

var files;

Directory tempDirectory;

List<FolderModel> folders = [];
List<PDFModel> pdfs = [];
List<TagModel> tags = [];

final floatIcons = [
  Icons.add,
  Icons.clear
];

final floatIconColors = [
  kGreenColor,
  kBlueColor,
  kMainTextColor
];

List<CityModel> cityDistricts = [];

final menuTitles = [
  appLocale.translate('rename'),
  appLocale.translate('move'),
  appLocale.translate('delete'),
];

Future<bool> createNewFolder(String newFolderPath) async {
  bool isSuccess = false;
  new Directory(appDirectory).create(recursive: false).then((value) => {isSuccess = true}).catchError((onError){isSuccess = false;});
  return isSuccess;
}

Future<String> getPDFPathFromAsset(BuildContext context, String assetPDFUri) async {
  final ByteData bytes = await DefaultAssetBundle.of(context).load(assetPDFUri);
  final Uint8List list = bytes.buffer.asUint8List();

  final tempDocumentPath = '${tempDirectory.path}/$assetPDFUri';
  final file = await File(tempDocumentPath).create(recursive: true);
  file.writeAsBytesSync(list);
  return tempDocumentPath;
}

showAlertDialog(BuildContext context, String title, String content, Function okCallback, Function cancelCallback){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(content),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              cancelCallback();
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(appLocale.translate('cancel')),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              okCallback();
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(appLocale.translate('ok')),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 12,
      );
    }
  );
}

Future<void> displayTextInputDialog(BuildContext context, String titleText, String initText, String hintText, String toastText, Function okCallback) async{
  TextEditingController txtNewFolder = new TextEditingController();
  txtNewFolder.text = initText;
  return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(titleText),
          content: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 132,
            margin: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                TextField(
                  controller: txtNewFolder,
                  decoration: InputDecoration(
                      hintText: hintText
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 44,
                            child: Center(child: Text(appLocale.translate('cancel'), style: gilroyStyleBold().copyWith(color: kWhiteColor, fontSize: 16),)),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: kTextGreenColor,
                                borderRadius: BorderRadius.all(Radius.circular(22.0)),
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 3.0
                                )
                                ]
                            ),
                          ),
                        ),
                      ),
                      Container(width: 12,),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            if(txtNewFolder.text != ''){
                              Navigator.of(context).pop();
                              okCallback(txtNewFolder.text);
                            }else{
                              showToast(toastText);
                            }
                          },
                          child: Container(
                            height: 44,
                            child: Center(child: Text(appLocale.translate('ok'), style: gilroyStyleBold().copyWith(color: kWhiteColor, fontSize: 16),)),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: kGreenLightColor,
                                borderRadius: BorderRadius.all(Radius.circular(22.0)),
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 3.0
                                )
                                ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: 12,
        );
      }
  );
}

void showToast(String msg){
  Fluttertoast.showToast(
    msg: msg,
    textColor: kWhiteColor,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
  );
}

List<FolderModel> loadFolders(){
  List<FolderModel> folders = [];

  List<ImageModel> images = [
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
  ];

  folders.add(new FolderModel(folderName: 'Folder 1', createdDate: 'Febrary 3, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 2', createdDate: 'Febrary 4, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 3', createdDate: 'Febrary 5, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 4', createdDate: 'Febrary 6, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 5', createdDate: 'Febrary 7, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 6', createdDate: 'Febrary 8, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 7', createdDate: 'Febrary 9, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 8', createdDate: 'Febrary 10, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 9', createdDate: 'Febrary 11, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 10', createdDate: 'Febrary 12, 8:00 AM', images: images));
  folders.add(new FolderModel(folderName: 'Folder 11', createdDate: 'Febrary 13, 8:00 AM', images: images));

  return folders;
}

List<TagModel> loadTags() {
  List<TagModel> tags = [];

  List<ImageModel> images = [
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
    new ImageModel(),
  ];

  tags.add(new TagModel(tagName: 'Biology', createdDate: 'Febrary 3, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Science', createdDate: 'Febrary 4, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Misc', createdDate: 'Febrary 5, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Tag 4', createdDate: 'Febrary 6, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Tag 5',  createdDate: 'Febrary 7, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Tag 6', createdDate: 'Febrary 8, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Tag 4', createdDate: 'Febrary 9, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Tag 8', createdDate: 'Febrary 10, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Tag 9', createdDate: 'Febrary 11, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Tag 10', createdDate: 'Febrary 12, 8:00 AM', images: images));
  tags.add(new TagModel(tagName: 'Tag 11', createdDate: 'Febrary 13, 8:00 AM', images: images));

  return tags;
}

loadPDFs(){
  List<PDFModel> pdfs = [];

  pdfs.add(new PDFModel(pdfName: 'TYT_1 CozKazan(5li) M', createdDate: 'Febrary 3, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_2 CozKazan(5li) M', createdDate: 'Febrary 4, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_3 CozKazan(5li) M', createdDate: 'Febrary 5, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_4 CozKazan(5li) M', createdDate: 'Febrary 6, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_5 CozKazan(5li) M', createdDate: 'Febrary 7, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_6 CozKazan(5li) M', createdDate: 'Febrary 8, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_7 CozKazan(5li) M', createdDate: 'Febrary 9, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_8 CozKazan(5li) M', createdDate: 'Febrary 10, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_9 CozKazan(5li) M', createdDate: 'Febrary 11, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_10 CozKazan(5li) M', createdDate: 'Febrary 12, 8:00 AM'));
  pdfs.add(new PDFModel(pdfName: 'TYT_11 CozKazan(5li) M', createdDate: 'Febrary 13, 8:00 AM'));

  return pdfs;
}

int citiesIndex = 0;
int districtIndex = 0;
int schoolIndex = 0;

List<String> districtItems = [];
List<String> schoolItems = [];

void loadDistricts(){
  districtIndex = 0;
  districtItems.clear();
  for(int i=0; i < cityDistricts.length; i++){
    if(cityDistricts[i].cityName == cityItems[citiesIndex]){
      if(!checkDistrictSame(districtItems, cityDistricts[i].districtName)){
        districtItems.add(cityDistricts[i].districtName);
      }
    }
  }
}

void loadSchool(){
  schoolIndex = 0;
  schoolItems.clear();
  for(int i=0; i < cityDistricts.length; i++){
    if(cityDistricts[i].districtName == districtItems[districtIndex]){
      if(!checkDistrictSame(schoolItems, cityDistricts[i].schoolName)){
        schoolItems.add(cityDistricts[i].schoolName);
      }
    }
  }
}

bool checkDistrictSame(List<String> list, String val){
  for(int i=0; i < list.length; i++){
    if(val == list[i]){
      return true;
    }
  }
  return false;
}

onImageButtonPressed(ImageSource source, {BuildContext context, capturedImageFile}) async {
  final ImagePicker _picker = ImagePicker();
  File val;

  final pickedFile = await _picker.getImage(
    source: source,
  );

  val = await ImageCropper.cropImage(
    sourcePath: pickedFile.path,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    compressQuality: 100,
    maxHeight: 700,
    maxWidth: 700,
    compressFormat: ImageCompressFormat.jpg,
    androidUiSettings: AndroidUiSettings(
      toolbarColor: Colors.white,
      toolbarTitle: "genie cropper",
    ),
  );
  capturedImageFile(val.path);
}

typedef capturedImageFile = String Function(String);
typedef void OnPickImageCallback(double maxWidth, double maxHeight, int quality);

List <String> alanItems = [
  'LGS',
  'YKS EA',
  'YKS SAY',
  'YKS SÖZ',
  'YKS DİL',
  'KPSS Önlisans',
  'KPSS Lisans',
  'ALES',
  'TUS',
  'DUS',
  'YDS'
];

List <String> classItems = [
  '6.Sınıf',
  '7.Sınıf',
  '8.Sınıf',
  '9.Sınıf',
  '10.Sınıf',
  '11.Sınıf',
  '12.Sınıf',
  'Mezun',
  'Önlisans',
  'Lisans',
  'Yükseklisans'
];

List <String> cityItems = [
  'ADANA',
  'ADIYAMAN',
  'AFYONKARAHİSAR',
  'AĞRI',
  'AKSARAY',
  'AMASYA',
  'ANKARA',
  'ANTALYA',
  'ARDAHAN',
  'ARTVİN',
  'AYDIN',
  'BALIKESİR',
  'BARTIN',
  'BATMAN',
  'BAYBURT',
  'BİLECİK',
  'BİNGÖL',
  'BİTLİS',
  'BOLU',
  'BURDUR',
  'BURSA',
  'ÇANAKKALE',
  'ÇANKIRI',
  'ÇORUM',
  'DENİZLİ',
  'DİYARBAKIR',
  'DÜZCE',
  'EDİRNE',
  'ELAZIĞ',
  'ERZİNCAN',
  'ERZURUM',
  'ESKİŞEHİR',
  'GAZİANTEP',
  'GİRESUN',
  'GÜMÜŞHANE',
  'HAKKARİ',
  'HATAY',
  'IĞDIR',
  'ISPARTA',
  'İSTANBUL',
  'İZMİR',
  'KAHRAMANMARAŞ',
  'KARABÜK',
  'KARAMAN',
  'KARS',
  'KASTAMONU',
  'KAYSERİ',
  'KIRIKKALE',
  'KIRKLARELİ',
  'KIRŞEHİR',
  'KİLİS',
  'KOCAELİ',
  'KONYA',
  'KÜTAHYA',
  'MALATYA',
  'MANİSA',
  'MARDİN',
  'MERSİN',
  'MUĞLA',
  'MUŞ',
  'NEVŞEHİR',
  'NİĞDE',
  'ORDU',
  'OSMANİYE',
  'RİZE',
  'SAKARYA',
  'SAMSUN',
  'SİİRT',
  'SİNOP',
  'SİVAS',
  'ŞANLIURFA',
  'ŞIRNAK',
  'TEKİRDAĞ',
  'TOKAT',
  'TRABZON',
  'TUNCELİ',
  'UŞAK',
  'VAN',
  'YALOVA',
  'YOZGAT',
  'ZONGULDAK',
];



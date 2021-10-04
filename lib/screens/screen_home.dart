import 'package:filemanagerdx/components/nav_drawer.dart';
import 'package:filemanagerdx/fragments/fragment_folders.dart';
import 'package:filemanagerdx/models/tag_model.dart';
import 'package:filemanagerdx/services/navigation_service.dart';
import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:filemanagerdx/themes/widget_styles.dart';
import 'package:filemanagerdx/utils/sharedpref.dart';
import 'package:filemanagerdx/utils/utils_app.dart';
import 'package:filemanagerdx/utils/utils_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({@required this.path}) : assert(path != null);
  final String path;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  AnimationController _animationController;

  int frgIndex = MENU_INBOX;
  List<String> titles = [
    appLocale.translate('sonuDefterim'),
    appLocale.translate('myPDF'),
    appLocale.translate('profile'),
    appLocale.translate('tagManager'),
    appLocale.translate('BuyPackage'),
  ];

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rightSlide = MediaQuery.of(context).size.width * 0.8;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context,child){
        double slide = rightSlide*_animationController.value;
        double scale = 1 - (_animationController.value * 0.3);
        return Stack(
          children: [
            Scaffold(
              backgroundColor: kHomeBackgroundColor,
              appBar: NoTitleBarWidget(),
              body: DrawerData((index) => {
                  selFragment(index),
                }
              ),
            ),
            Transform(
              transform: Matrix4.identity()..translate(slide)..scale(scale),
              alignment: Alignment.centerLeft,
              child: Scaffold(
                backgroundColor: kWhiteColor,
                appBar: NoTitleBarWidget(),
                body: Stack(
                  children: [
                    if(frgIndex == MENU_INBOX)
                      Container(
                        width: double.infinity, height: double.infinity,
                        child: FragFoldersScreen(path: widget.path, onMenuSlide: (){
                            _toggleAnimation();
                          },
                        ),
                      ),
                    // if(frgIndex == MENU_MY_PDF)
                    //   Container(
                    //     width: double.infinity, height: double.infinity,
                    //     child: MyPDFFragment((cellIndex, eventIndex){
                    //       processPDFClickCallback(context, cellIndex, eventIndex);
                    //     }),
                    //   ),
                    // if(frgIndex == MENU_TAG_MANAGER)
                    //   Container(
                    //     width: double.infinity, height: double.infinity,
                    //     child: TagsFragment((eventIndex, cellIndex, menuIndex){
                    //       processTagsCallback(context, eventIndex, cellIndex, menuIndex);
                    //     }
                    //     ),
                    //   ),
                    // if(frgIndex == MENU_BUY_PACKAGE)
                    //   Container(
                    //     width: double.infinity, height: double.infinity,
                    //     child: BuyPackageFragment((eventIndex, cellIndex, menuIndex){
                    //       processBuyCallback(context, eventIndex, cellIndex, menuIndex);
                    //     }
                    //     ),
                    //   ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> initData() async {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    folders.clear();
    folders = loadFolders();

    pdfs.clear();
    pdfs = loadPDFs();

    tags.clear();
    tags = loadTags();

    setState((){});
  }

  _toggleAnimation() {
    _animationController.isDismissed ? _animationController.forward() : _animationController.reverse();
  }

  selFragment(int _frgIndex) {
    switch(_frgIndex){
      case MENU_INBOX:
        frgIndex = MENU_INBOX;
        break;
      case MENU_MY_PDF:
        frgIndex = MENU_INBOX;
        break;
      case MENU_PROFILE:
        _animationController.reverse();
        // gotoProfile();
        break;
      case MENU_TAG_MANAGER:
        frgIndex = MENU_INBOX;
        break;
      case MENU_BUY_PACKAGE:
        frgIndex = MENU_INBOX;
        break;
      case MENU_LOCAL:
        // changeLocalStatus();
        // setState((){});
        break;
      case MENU_SIGN_OUT:
        showAlertDialog(context, appLocale.translate('signout'), appLocale.translate('confirmSignOut'), (){
            signOut();
          }, (){

          }
        );
        break;
    }

    _animationController.reverse();
    setState((){});
  }

  Future<void> signOut() async {
    await mAuth.signOut();
    // NavigationService().navigateToScreen(context, LoginPage(fbApp: widget.fbApp,), replace: true);
  }

}

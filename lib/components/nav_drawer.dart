import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:filemanagerdx/utils/utils_app.dart';
import 'package:filemanagerdx/utils/utils_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class DrawerData extends StatelessWidget {
  DrawerData(this.mFrgCallback, );
  Function mFrgCallback;

  @override
  Widget build(BuildContext context) {
    final List<DrawerItem> drawers = [
      DrawerItem(appLocale.translate('inbox'), Image.asset('assets/images/ic_inbox.png', width: 40,)),
      DrawerItem(appLocale.translate('myPDF'), Image.asset('assets/images/ic_pdf_menu.png', width: 40,)),
      DrawerItem(appLocale.translate('myProfile'), Image.asset('assets/images/ic_profile_menu.png', width: 40,)),
      DrawerItem(appLocale.translate('tagManager'), Image.asset('assets/images/ic_inbox.png', width: 40,)),
      DrawerItem(appLocale.translate('BuyPackage'), Image.asset('assets/images/ic_buy_pro.png', width: 40,)),
      DrawerItem(appLocale.translate('useMyLocal'), Image.asset('assets/images/ic_my_local.png', width: 40,)),
    ];
    return Container(
      width: 260, height: double.infinity,
      color: kWhiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 90, 16, 0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(defaultAvatarImgUrl, height: 60.0, width: 60.0,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(currentUser.firstName + ' ' + currentUser.surName, style: gilroyStyleBold().copyWith(fontSize: 18, color: kMainTextColor),),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 56,left: 16, right: 16),
            child: InkWell(
              onTap: (){
                mFrgCallback(MENU_INBOX);
              },
              child: Container(
                width: double.infinity, height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: drawers[0].icon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18 ),
                      child: Text(drawers[0].name,style: gilroyStyleMedium().copyWith(color: kMainTextColor, fontSize: 17),),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 16, right: 16),
            child: InkWell(
              onTap: (){
                mFrgCallback(MENU_MY_PDF);
              },
              child: Container(
                width: double.infinity, height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: drawers[1].icon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, ),
                      child: Text(drawers[1].name,style: gilroyStyleMedium().copyWith(color: kMainTextColor, fontSize: 17),),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 16, right: 16),
            child: InkWell(
              onTap: (){
                mFrgCallback(MENU_PROFILE);
              },
              child: Container(
                width: double.infinity, height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: drawers[2].icon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, ),
                      child: Text(drawers[2].name,style: gilroyStyleMedium().copyWith(color: kMainTextColor, fontSize: 17),),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 16, right: 16),
            child: InkWell(
              onTap: (){
                mFrgCallback(MENU_TAG_MANAGER);
              },
              child: Container(
                width: double.infinity, height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: drawers[3].icon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, ),
                      child: Text(drawers[3].name,style: gilroyStyleMedium().copyWith(color: kMainTextColor, fontSize: 17),),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 16, right: 16),
            child: InkWell(
              onTap: (){
                mFrgCallback(MENU_BUY_PACKAGE);
              },
              child: Container(
                width: double.infinity, height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: drawers[4].icon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, ),
                      child: Text(drawers[4].name,style: gilroyStyleMedium().copyWith(color: kMainTextColor, fontSize: 17),),
                    )
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20,left: 16, right: 16),
            child: InkWell(
              onTap: (){
                mFrgCallback(MENU_LOCAL);
              },
              child: Container(
                width: double.infinity, height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: drawers[5].icon,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, ),
                      child: Text(drawers[5].name,style: gilroyStyleMedium().copyWith(color: kMainTextColor, fontSize: 17),),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 6),
                      child: FlutterSwitch(
                        width: 50, height: 24.0,
                        value: localStatus,
                        borderRadius: 12,
                        activeText: '',
                        inactiveText: '',
                        activeColor: kSwitchActiveColor,
                        inactiveColor: kSwitchInActiveColor,
                        showOnOff: true,
                        onToggle: (val){
                          mFrgCallback(MENU_LOCAL);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48,left: 16, right: 16),
            child: InkWell(
              onTap: (){
                mFrgCallback(MENU_SIGN_OUT);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity, height: 44,
                color: Colors.transparent,
                child: Container(
                  child: new Center(
                    child: new Text(appLocale.translate('logout'),
                      style: abelStyleBold().copyWith(fontSize: 18, color: Color(0xff2cc7e1)),
                      textAlign: TextAlign.center,),
                  ),
                  decoration: BoxDecoration(
                      color: kLogoutColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem{
  final String name;
  final Image icon;

  const DrawerItem(this.name, this.icon);
}
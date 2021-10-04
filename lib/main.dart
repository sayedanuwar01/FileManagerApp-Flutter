import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_localizations.dart';
import 'package:filemanagerdx/languages/lang_localization.dart';
import 'package:filemanagerdx/notifiers/core.dart';
import 'package:filemanagerdx/screens/screen_home.dart';
import 'package:filemanagerdx/services/loader_service.dart';
import 'package:filemanagerdx/services/navigation_service.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:filemanagerdx/themes/widget_styles.dart';
import 'package:filemanagerdx/utils/sharedpref.dart';
import 'package:filemanagerdx/utils/utils_app.dart';
import 'package:filemanagerdx/utils/utils_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:filemanagerdx/notifiers/preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'helpers/filesystem_utils.dart';
import 'models/city_model.dart';
import 'models/user_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp fbApp = await Firebase.initializeApp (
    name: 'Soru-Sakla',
    options: Platform.isIOS || Platform.isMacOS ?
    FirebaseOptions(
      appId: '1:588820333036:ios:48aed87c9b962921fa40c9',
      apiKey: 'AIzaSyC7ToSkEcMZfsppFM19TtPOhSEjKoTPWzU',
      projectId: 'soru-sakla-c1751',
      messagingSenderId: '588820333036',
      databaseURL: 'https://soru-sakla-c1751-default-rtdb.firebaseio.com/',
    ) :
    FirebaseOptions(
      appId: '1:588820333036:android:66aeef8e08d328c2fa40c9',
      apiKey: 'AIzaSyC7ToSkEcMZfsppFM19TtPOhSEjKoTPWzU',
      projectId: 'soru-sakla-c1751',
      messagingSenderId: '588820333036',
      databaseURL: 'https://soru-sakla-c1751-default-rtdb.firebaseio.com/',
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(MultiProvider(
    providers: [
      ValueListenableProvider(create: (context) => ValueNotifier(true)),
      ChangeNotifierProvider(create: (context) => CoreNotifier()),
      ChangeNotifierProvider(create: (context) => PreferencesNotifier()),
    ],
    child: MyApp(fbApp: fbApp,),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.fbApp});
  final FirebaseApp fbApp;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('tr', ''),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var langItem in supportedLocales) {
            if (langItem.languageCode == locale.languageCode) {
              appLocale = AppLocalizations(langItem);
              appLocale.load();
              return langItem;
            }
          }
          appLocale = AppLocalizations(supportedLocales.first);
          appLocale.load();
          return supportedLocales.first;
        },
        title: 'Soru Sakla',
        home: SplashScreen(fbApp: fbApp,)
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({this.fbApp});
  final FirebaseApp fbApp;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  DatabaseReference userRef;

  Timer timer;

  @override
  Future<void> initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: mainGradient(),
          child: Column(
            children: [
              Expanded(flex: 1, child: Container(),),
              Container(
                child: Text(
                  appName, style: abelStyleBold().copyWith(fontSize: 34,)),
              ),
              Expanded(flex: 1, child: Container(),),
            ],
          ),
        )
    );
  }

  initData() async {
    currentUser = new UserModel();
    userRef = FirebaseDatabase.instance.reference().child(TB_USER);

    localStatus = await SharedPrefs.getBool(SharedPrefs.KEY_LOCAL_STATUS, defaultValue: true);
    inboxFilter = await SharedPrefs.getBool(SharedPrefs.KEY_INBOX_FILTER, defaultValue: true);
    tagsFilter = await SharedPrefs.getBool(SharedPrefs.KEY_TAGS_FILTER, defaultValue: true);

    loadCities();
  }

  Future loadCities() async {
    String jsonString = await _loadCitiesAsset();
    final jsonResponse = json.decode(jsonString);

    List<dynamic> mapString = jsonResponse['Sayfa1'] as List<dynamic>;
    for(int i=0; i< mapString.length; i++){
      CityModel cityModel = CityModel.fromJson(mapString[i]);
      cityDistricts.add(cityModel);
    }

    loadDistricts();
    loadSchool();

    Timer.run(() {
      LoaderService().showLoading(context);
    });
    loadTimer();
  }

  Future<String> _loadCitiesAsset() async {
    return await rootBundle.loadString('assets/cities/cities.json');
  }

  loadTimer(){
    timer = Timer(const Duration(seconds: 1), () {
        _requestPermissions();
      }
    );
  }

  Future<void> _requestPermissions() async {
    if (await SimplePermissions.checkPermission(Permission.WriteExternalStorage)) {
      loadFiles();
    }else{
      loadTimer();
    }
  }

  loadFiles() async {
    await createAppRootPath();

    List<Directory> paths = await getExternalStorageDirectories();
    for (Directory dir in paths) {
      await getExternalStorageWithoutDataDir(dir.absolute.path);
    }

    var coreNotifier = Provider.of<CoreNotifier>(context, listen: false);
    coreNotifier.currentPath = Directory(rootFolders);

    if (mAuth.currentUser != null) {
      fetchUserModel(mAuth.currentUser.uid);
    }else{
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);
      NavigationService().navigateToScreen(context, HomeScreen(path: rootFolders), replace: true);
      //NavigationService().navigateToScreen(context, LoginPage(fbApp: widget.fbApp,), replace: true);
    }
  }

  Future<void> fetchUserModel(userId) async {
    await userRef.child(userId).once().then((DataSnapshot snapshot) {
      if(LoaderService().checkLoading())
        LoaderService().hideLoading(context);
      if(snapshot.value != null){
        showToast(appLocale.translate('logInSuccessed'));
        currentUser = UserModel.fromJson(snapshot.value);

        packageModel.userId = currentUser.userId;
        NavigationService().navigateToScreen(context, HomeScreen(path: rootFolders), replace: true);
      }else{
        NavigationService().navigateToScreen(context, HomeScreen(path: rootFolders), replace: true);
        //NavigationService().navigateToScreen(context, LoginPage(fbApp: widget.fbApp,), replace: true);
      }
    });
  }
}

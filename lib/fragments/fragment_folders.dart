import 'dart:io';

// framework
import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:filemanagerdx/utils/utils_app.dart';
import 'package:flutter/material.dart';

// packages
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as pathlib;

// app files
import 'package:filemanagerdx/notifiers/core.dart';
import 'package:filemanagerdx/ui/widgets/appbar_popup_menu.dart';
import 'package:filemanagerdx/ui/widgets/search.dart';
import 'package:filemanagerdx/notifiers/preferences.dart';
import 'package:filemanagerdx/ui/widgets/create_dialog.dart';
import 'package:filemanagerdx/ui/widgets/file.dart';
import 'package:filemanagerdx/ui/widgets/folder.dart';
import 'package:filemanagerdx/helpers/filesystem_utils.dart' as filesystem;
import 'package:filemanagerdx/ui/widgets/context_dialog.dart';
import 'package:filemanagerdx/helpers/io_extensions.dart';
import 'package:filemanagerdx/ui/widgets/appbar_path_widget.dart';

class FragFoldersScreen extends StatefulWidget {
  FragFoldersScreen({@required this.path, this.onMenuSlide}) : assert(path != null);
  Function onMenuSlide;
  final String path;

  @override
  _FragFoldersScreenState createState() => _FragFoldersScreenState();
}

class _FragFoldersScreenState extends State<FragFoldersScreen> with AutomaticKeepAliveClientMixin {
  String appBarTitle = appLocale.translate('sonuDefterim');
  var coreNotifier;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final preferences = Provider.of<PreferencesNotifier>(context);
    coreNotifier = Provider.of<CoreNotifier>(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, val) => [
          SliverAppBar(
            floating: true,
            title: Text(appBarTitle, style: gilroyStyleBold().copyWith(color: kMainTextColor, fontSize: 20),),
            leading: IconButton(
              icon: Image.asset('assets/images/ic_appbar_menu.png', width: 32,),
              onPressed: () {
                onClickBackbutton();
              }
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: Image.asset('assets/images/ic_search.png', width: 32,),
                onPressed: (){
                  onShowSearch();
                },
              ),
              AppBarPopupMenu(path: coreNotifier.currentPath.absolute.path),
            ],
          ),
        ],
        body: Consumer<CoreNotifier>(
          builder: (context, model, child) => StreamBuilder<List<FileSystemEntity>>(
            stream: filesystem.fileStream(model.currentPath.absolute.path, keepHidden: preferences.hidden),
            builder: (BuildContext context, AsyncSnapshot<List<FileSystemEntity>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: Text('Press button to start.'));
                case ConnectionState.active:
                  return Container(width: 0.0, height: 0.0);
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    if (snapshot.error is FileSystemException) {
                      return Center(child: Text("Permission Denied"));
                    }
                  } else if (snapshot.data.length != 0) {
                    debugPrint("FolderListScreen -> Folder Grid: data length = ${snapshot.data.length} ");
                    return Container(
                      color: Colors.red,
                    );
                  } else {
                    return Center(
                      child: Text("Empty Directory!"),
                    );
                  }
              }
              return null; // unreachable
            },
          ),
        ),
      ),

      // check if the in app floating action button is activated in settings
      floatingActionButton: StreamBuilder<bool>(
        stream: preferences.showFloatingButton, //	a	Stream<int>	or	null
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) return Text('Error:	${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Select	lot');
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return FolderFloatingActionButton(
                enabled: snapshot.data,
                path: widget.path,
              );
            case ConnectionState.done:
              FolderFloatingActionButton(enabled: snapshot.data);
          }
          return null;
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void onShowSearch() {
    showSearch(context: context, delegate: Search(path: widget.path));
  }

  void onClickBackbutton() {
    if (coreNotifier.currentPath.absolute.path != '/storage/emulated/0/SoruSkala/Folders') {
      coreNotifier.navigateBackdward();
    }else{
      widget.onMenuSlide();
    }
  }
}

_printFuture(Future<String> open) async {
  print("Opening: " + await open);
}

class FolderFloatingActionButton extends StatelessWidget {
  const FolderFloatingActionButton({Key key, this.enabled, this.path}) : super(key: key);
  final bool enabled;
  final String path;

  @override
  Widget build(BuildContext context) {
    var coreNotifier = Provider.of<CoreNotifier>(context);
    if (enabled == true) {
      return FloatingActionButton(
        tooltip: "Create Folder",
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => CreateDialog(
            path: coreNotifier.currentPath.absolute.path,
            onCreate: (path) {
              filesystem.createFolderByPath(path);
              coreNotifier.reload();
            },
          )
        ),
      );
    }
    else return Container(width: 0.0, height: 0.0,);
  }
}

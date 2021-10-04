// framework
import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:flutter/material.dart';

// packages
import 'package:provider/provider.dart';

// app files
import 'package:filemanagerdx/notifiers/core.dart';
import 'package:filemanagerdx/ui/widgets/create_dialog.dart';
import 'package:filemanagerdx/helpers/filesystem_utils.dart' as filesystem;

class AppBarPopupMenu extends StatelessWidget {
  final String path;
  const AppBarPopupMenu({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoreNotifier>(
      builder: (context, model, child) => PopupMenuButton<String>(
        icon: Icon(Icons.more_vert, color: kMainTextColor, size: 26,),
        onSelected: (value) {
          if (value == "refresh") {
            model.reload();
          } else if (value == "folder") {
            showDialog(
              context: context,
              builder: (context) => CreateDialog(
                onCreate: (path) {
                  filesystem.createFolderByPath(path);
                  model.reload();
                },
                path: path,
                title: Text("Create new folder"),
              )
            );
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
          const PopupMenuItem<String>(
            value: 'refresh', child: Text('Refresh', style: TextStyle(color: kMainTextColor),),
          ),
          const PopupMenuItem<String>(
            value: 'folder', child: Text('New Folder', style: TextStyle(color: kMainTextColor)),
          ),
        ]
      ),
    );
  }
}

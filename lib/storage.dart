

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
class Storage_firebase{
  final FirebaseStorage fs=FirebaseStorage.instance;

  // import 'package:firebase_storage/firebase_storage.dart';

  // Future<List<String>> listFolders(String folderPath) async {
  //   ListResult result = await fs.ref(folderPath).listAll();
  //
  //   List<String> folderNames = [];
  //
  //   for (var item in result.prefixes) {
  //     folderNames.add(item.fullPath);
  //   }
  //
  //   return folderNames;
  // }

  // Future<List<String>> listFiles(String folderPath) async {
  //   ListResult result = await fs.ref(folderPath).listAll();
  //
  //   List<String> fileNames = [];
  //
  //   for (var item in result.items) {
  //     fileNames.add(item.fullPath);
  //   }
  //
  //   return fileNames;
  // }

  List<String> folderNames_temp = [];
  List<String> folderNames = [];

  List<String> searchFolders(String query) {
    folderNames_temp=folderNames;
    String queryLower = query.toLowerCase();
    print('/////${queryLower}');
    List<String> filteredFolders = folderNames_temp.where((folder) => folder.toLowerCase().contains(queryLower)).toList();
    if(query.isEmpty) filteredFolders=[];
    return filteredFolders;
  }

  Future<List<String>> listFiles() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    ListResult result = await storage.ref('tmkc').listAll();

    // Filtering out the folders from the items
    for (var item in result.prefixes) {
      folderNames.add(item.fullPath);
    }

    // Printing folder names or returning as needed
    folderNames.forEach((folderName) {
      print("Folder found: $folderName");
    });
    folderNames_temp=folderNames;
    return folderNames;
  }


// Future<ListResult> listFiles() async{
  //   ListResult results=await fs.ref('tmkc').listAll();
  //   // print(results);
  //   results.items.forEach((Reference ref) { print("file is found $ref"); });
  //   return results;
  // }
}




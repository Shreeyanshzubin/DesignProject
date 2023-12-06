

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
class Storage_firebase{
  final FirebaseStorage fs=FirebaseStorage.instance;

  Future<ListResult> listFiles() async{
    ListResult results=await fs.ref('tmkc').listAll();
    results.items.forEach((Reference ref) { print("file is found $ref"); });
    return results;
  }
}

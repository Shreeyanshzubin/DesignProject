
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_share_clone_app/settings.dart';
import 'package:photo_share_clone_app/storage.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchApp(),
    );
  }
}

class SearchResult {
  final String text;

  SearchResult({required this.text});
}

class SearchApp extends StatefulWidget {
  @override
  _SearchAppState createState() => _SearchAppState();
}

class _SearchAppState extends State<SearchApp> {
  String searchText = "";
  TextEditingController searchController = TextEditingController();
  List<SearchResult> searchResults = [];
  bool isGridView = false;

  void search(String query) {
    setState(() {
      searchText = query;
    });
  }

  Future<void> performSearch() async {
    try {
      String baseUrl = 'gs://share-clone.appspot.com'; // Update with your Firebase Storage URL
      String folderPath = 'tmkc';
      print("Fetching images...");
      print(await FirebaseStorage.instance.ref().child(folderPath).list);
      ListResult result = await FirebaseStorage.instance.ref().child(folderPath).list();
      List<String> urls = await Future.wait(result.items.map((item) => item.getDownloadURL()));

      List<SearchResult> newSearchResults = urls.map((url) {
        return SearchResult(text: url);
      }).toList();

      setState(() {
        searchResults = newSearchResults;
      });
    } catch (e) {
      print("Error fetching images: $e");
    }
  }

  void toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }



  void _showImageDialog()
  {
    showDialog(
        context: context,
        builder: (context){

          return AlertDialog(
            title: const Text("Please choose an Image"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    _getFromCamera();
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    _getFromGallery();
                  },
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  void _getFromCamera() async
  {
    XFile? pickedFile =  await ImagePicker().pickImage(source: ImageSource.camera);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Storage_firebase storage = Storage_firebase();
    return Scaffold(
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: "1",
              backgroundColor: Colors.blueAccent.shade700,
              onPressed: (){
                _showImageDialog();

              },
              child: const Icon(Icons.camera_enhance),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: "2",
              backgroundColor: Colors.blueAccent.shade700,
              onPressed: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Settings()));
              },
              child: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('𝕊𝕟𝕒𝕡𝕊𝕖𝕖𝕜𝕖𝕣'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (query) {
                      search(query);
                    },
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        performSearch();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Code',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    // if (searchText.isNotEmpty) {
                     await performSearch();
                    // }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.view_module),
                  onPressed: () {
                    toggleView();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          FutureBuilder(future: storage.listFiles(), builder: (context,AsyncSnapshot<ListResult> snapshot){
            if(snapshot.connectionState==ConnectionState.done &&  snapshot.hasData){
              return Container(
                height: 100,
                child: ListView.builder(

                  shrinkWrap: true,
                  itemCount:snapshot.data!.items.length,itemBuilder: (context,i){
                return Text(snapshot.data!.items[i].name);
              }),);
            }
            return Text('No data found');
          })

          // Expanded(
          //   child: isGridView
          //       ? buildGridView()
          //       : buildListView(),
          // ),
        ],
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  searchResult: searchResults[index],
                ),
              ),
            );
          },
          child: SearchItem(searchResult: searchResults[index]),
        );
      },
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  searchResult: searchResults[index],
                ),
              ),
            );
          },
          child: SearchItem(searchResult: searchResults[index]),
        );
      },
    );
  }
}

class SearchItem extends StatelessWidget {
  final SearchResult searchResult;

  SearchItem({required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            searchResult.text,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            searchResult.text,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final SearchResult searchResult;

  DetailPage({required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              searchResult.text,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              searchResult.text,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
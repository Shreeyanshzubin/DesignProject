// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ImageListScreen extends StatefulWidget {
//   final String folderPath;
//
//   const ImageListScreen({Key? key, required this.folderPath}) : super(key: key);
//
//   @override
//   _ImageListScreenState createState() => _ImageListScreenState();
// }
//
// class _ImageListScreenState extends State<ImageListScreen> {
//   List<String> imageUrls = [];
//   bool isLoading = true; // To track if data is loading or not
//
//   @override
//   void initState() {
//     super.initState();
//     fetchImages(widget.folderPath);
//   }
//
//   Future<void> fetchImages(String folderPath) async {
//     FirebaseStorage storage = FirebaseStorage.instance;
//     Reference folderRef = storage.ref().child(folderPath);
//
//     ListResult result = await folderRef.listAll();
//
//     List<String> urls = [];
//
//     for (var item in result.items) {
//       String url = await item.getDownloadURL();
//       urls.add(url);
//     }
//
//     setState(() {
//       imageUrls = urls;
//       isLoading = false; // Set loading to false after data is fetched
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Images in ${widget.folderPath}'),
//       ),
//       body: isLoading
//           ? Center(
//         child: CircularProgressIndicator(), // Show CircularProgressIndicator while loading
//       )
//           : Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 15.0,
//             mainAxisSpacing: 12.0,
//                     ),
//                     itemCount: imageUrls.length,
//                     itemBuilder: (BuildContext context, int index) {
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Image.network(
//                 imageUrls[index],
//                 fit: BoxFit.cover,
//               ),
//             );
//                     },
//                   ),
//           ),
//     );
//   }
// }
//
//
//
//



import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageListScreen extends StatefulWidget {
  final String folderPath;

  const ImageListScreen({Key? key, required this.folderPath}) : super(key: key);

  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  List<String> imageUrls = [];
  bool isLoading = true; // To track if data is loading or not

  @override
  void initState() {
    super.initState();
    fetchImages(widget.folderPath);
  }

  Future<void> fetchImages(String folderPath) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference folderRef = storage.ref().child(folderPath);

    ListResult result = await folderRef.listAll();

    List<String> urls = [];

    for (var item in result.items) {
      String url = await item.getDownloadURL();
      urls.add(url);
    }

    setState(() {
      imageUrls = urls;
      isLoading = false; // Set loading to false after data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images in ${widget.folderPath}'),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 12.0,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Navigate to full-screen image page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(imageUrl: imageUrls[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';




class TST_SCR extends StatefulWidget {
  const TST_SCR({super.key});

  @override
  State<TST_SCR> createState() => _TST_SCRState();
}

class _TST_SCRState extends State<TST_SCR> {
  List<String> _imageUrls = [    'https://picsum.photos/id/100/200/200',    'https://picsum.photos/id/101/200/200',    'https://picsum.photos/id/102/200/200',    'https://picsum.photos/id/103/200/200',  ];
  String _selectedImageUrl = 'https://picsum.photos/id/100/200/200';

  @override
  void initState() {
    super.initState();
    // _loadSelectedImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile Picture Picker'),
      // ),
      // body: Center(
      //   child: GestureDetector(
      //     onTap: () async {
      //       final selectedImageUrl = await _showImagePickerOptions(context);
      //       if (selectedImageUrl != null) {
      //         setState(() {
      //           _selectedImageUrl = selectedImageUrl;
      //         });
      //         _saveSelectedImageUrl(selectedImageUrl);
      //       }
      //     },
      //     child: CircleAvatar(
      //       radius: 50,
      //       backgroundImage: NetworkImage(_selectedImageUrl),
      //     ),
      //   ),
      // ),
    );
  }

  // Future _showImagePickerOptions(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 200,
  //         child: ListView.builder(
  //           itemCount: _imageUrls.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return ListTile(
  //               leading: Image.network(_imageUrls[index]),
  //               title: Text(_imageUrls[index]),
  //               onTap: () {
  //                 Navigator.pop(context, _imageUrls[index]);
  //               },
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  // _loadSelectedImageUrl() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _selectedImageUrl = prefs.getString('selectedImageUrl') ?? _selectedImageUrl;
  //   });
  // }
}
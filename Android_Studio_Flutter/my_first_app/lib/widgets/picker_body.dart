import 'package:flutter/material.dart';
import 'package:my_first_app/repo/image_repository.dart';

import '../models/image_model.dart';
class NetworkImagePickerBody extends StatelessWidget {
  final Function(String) onImageSelected;

  NetworkImagePickerBody({Key? key, required this.onImageSelected})
      : super(key: key);

  final ImageRepository _imageRepo = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: FutureBuilder<List<PixelformImage>>(
        future: _imageRepo.getNetworkImages(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PixelformImage>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  height: 200,
                  child: GestureDetector(
                    onTap: () {
                      onImageSelected(snapshot.data![index].image);
                    },
                    child: Image.network(
                      snapshot.data![index].image,
                      height: 50,
                      width: 50,
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 2,
                maxCrossAxisExtent:
                MediaQuery.of(context).size.width * 0.5,
                mainAxisSpacing: 3,
              ),
            );
          } else {
            return Text('No Data Available');
          }
        },
      ),
    );
  }
}

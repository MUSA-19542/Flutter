
import 'dart:convert';

import '../models/image_model.dart';
import 'package:http/http.dart' as http;
class ImageRepository
{


  Future<List<PixelformImage>> getNetworkImages() async {
    try {
      var endpointUrl = Uri.parse('https://fakestoreapi.com/products');
      final response = await http.get(endpointUrl);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body) as List;
        final List<PixelformImage> _imageList = decodedList.map((listItem) {
          return PixelformImage.fromJson(listItem);
        }).toList();

        // Move the print statement here
        print(
            "<=====================================thumbnail ============================================================>");
        print(_imageList[0].image);

        return _imageList;
      } else {
        throw Exception('Url Not Exists');
      }
    }
    catch(e)
    {
 print(e);
 throw Exception('Unknown error');

    }

  }
}
import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class PixelformImage {
  String title;
  int id;
  String description;
  double price;
  String category;
  @JsonKey(name : 'image')
  String image;
  @JsonKey(name : 'rating')
  Map<String,double> rating;

  PixelformImage(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.category,
      required this.rating,
      required this.image});

  factory PixelformImage.fromJson(Map<String, dynamic> json) =>
      _$PixelformImageFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PixelformImageToJson(this);
}

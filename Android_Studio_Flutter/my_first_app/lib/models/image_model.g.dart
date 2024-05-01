// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PixelformImage _$PixelformImageFromJson(Map<String, dynamic> json) =>
    PixelformImage(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      rating: (json['rating'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      image: json['image'] as String,
    );

Map<String, dynamic> _$PixelformImageToJson(PixelformImage instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating,
    };

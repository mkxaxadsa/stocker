// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsItemModel {
  final String title;
  final String text;
  final String imageUrl;
  final DateTime creationDate;
  const NewsItemModel({
    required this.title,
    required this.text,
    required this.imageUrl,
    required this.creationDate,
  });
}

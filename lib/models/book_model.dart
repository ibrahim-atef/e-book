class Book {
   final String title;
  final String coverImage;
  final String pdfLink;
  final String category;
  final String author;
   final String voiceLink;


  Book({
     required this.title,
    required this.coverImage,
    required this.pdfLink,
    required this.category,
    required this.author,
     required this.voiceLink,

  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
       title: json['title'] ?? '',
      coverImage: json['coverImage'] ?? '',
      pdfLink: json['pdfLink'] ?? '',
      category: json['category'] ?? '',
      author: json['author'] ?? '',
       voiceLink: json['voiceLink'] ?? '',
     );
  }

  Map<String, dynamic> toJson() {
    return {
       'title': title,
      'coverImage': coverImage,
      'pdfLink': pdfLink,
      'category': category,
      'author': author,
       'voiceLink': voiceLink,
     };
  }
}

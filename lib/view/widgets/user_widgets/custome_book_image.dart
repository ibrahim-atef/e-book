import 'package:flutter/material.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 2.6 / 4,
        child: Image.network(
          'https://marketplace.canva.com/EAFfSnGl7II/2/0/1003w/canva-elegant-dark-woods-fantasy-photo-book-cover-vAt8PH1CmqQ.jpg', // Directly pass the imageUrl string here
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
          
        
            return const Icon(Icons.error_outline_outlined);
          },
        ),
      ),
    );
  }
}

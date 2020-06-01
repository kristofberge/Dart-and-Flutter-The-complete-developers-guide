import 'package:flutter/material.dart';
import '../models/imageModel.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (_, index) {
        return Column(
          children: <Widget>[
            buildImage(index),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(images[index].title),
            )
          ],
        );
      },
    );
  }

  Container buildImage(int index) {
    return Container(
            child: Image.network(images[index].url),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
          );
  }
}

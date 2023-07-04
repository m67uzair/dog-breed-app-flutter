import 'package:flutter/material.dart';

class ImageAppBar extends StatelessWidget {
  final String? category;
  final String title;

  const ImageAppBar({
    super.key,
    required this.title,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    bool showBackButton = Navigator.of(context).canPop();

    return Material(
      elevation: 2,
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/cover.jpg"), fit: BoxFit.cover)),
        child: Container(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
            child: Row(
              mainAxisAlignment: showBackButton ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
              children: [
                if (showBackButton)
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.white,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: showBackButton ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      if (category != null)
                        Text(category ?? "", style: const TextStyle(fontSize: 18, color: Colors.white, height: 0.9)),
                      const SizedBox(height: 5),
                      Text(category == null ? title.toUpperCase() : convertString(title),
                          textAlign: showBackButton ? TextAlign.end : null,
                          // softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24, height: 0.9)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convertString(String input) {
    return input.replaceAll('/', '-');
  }
}

import 'package:dog_breed_app_flutter/controllers/api_helper.dart';
import 'package:dog_breed_app_flutter/widgets/image_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BreedDetailsScreen extends StatefulWidget {
  final String breedTitle;

  const BreedDetailsScreen({Key? key, required this.breedTitle}) : super(key: key);

  @override
  State<BreedDetailsScreen> createState() => _BreedDetailsScreenState();
}

class _BreedDetailsScreenState extends State<BreedDetailsScreen> {
  final ApiHelper apiHelper = ApiHelper();
  List imagesList = [];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        child: Scaffold(
          body: Column(
            children: [
              ImageAppBar(title: widget.breedTitle, category: 'BREED',),
              FutureBuilder(
                  future: apiHelper.getBreedImages(widget.breedTitle),
                  builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                    imagesList = snapshot.data ?? [];
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                        child: AlertDialog(
                          elevation: 0,
                          content: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return Expanded(
                          child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        itemCount: imagesList.length,
                        itemBuilder: (context, index) => SizedBox(
                          height: 120,
                          width: 120,
                          child: Card(
                            elevation: 2,
                            child: ClipRRect(borderRadius:
                            BorderRadius.circular(10), child: Image.network(imagesList[index], fit: BoxFit.cover)),
                          ),
                        ),
                      ));
                    } else {
                      return const Center(child: Text('Cant fetch Data'));
                    }
                  })
            ],
          ),
        ));
  }
}

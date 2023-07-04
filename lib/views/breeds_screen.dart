import 'package:dog_breed_app_flutter/controllers/api_helper.dart';
import 'package:dog_breed_app_flutter/views/breed_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:dog_breed_app_flutter/widgets/image_app_bar.dart';
import 'package:flutter/services.dart';

class BreedsScreen extends StatefulWidget {
  const BreedsScreen({Key? key}) : super(key: key);

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}

class _BreedsScreenState extends State<BreedsScreen> {
  final apiHelper = ApiHelper();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageAppBar(
              title: 'Browse\nBreeds',
            ),
            FutureBuilder(
              future: apiHelper.getBreeds(),
              builder: (BuildContext context, AsyncSnapshot<List<MapEntry>> snapshot) {
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
                  final breedsList = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemCount: breedsList.length,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      // itemExtent: 100,
                      itemBuilder: (context, index) {
                        final breedName = breedsList[index].key.toString().capitalizeWords();
                        final List subBreedList = breedsList[index].value;
                        return subBreedList.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                child: Material(
                                  elevation: 4,
                                  child: ListTile(
                                    leading: const Icon(Icons.pets),
                                    title: Text(
                                      breedName,
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BreedDetailsScreen(breedTitle: breedName),
                                          ));
                                    },
                                  ),
                                ),
                              )
                            : Theme(
                                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    child: ExpansionTile(
                                      leading: const Icon(Icons.pets),
                                      title: Text(
                                        breedName,
                                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                                      ),
                                      children: subBreedList
                                          .map((subBreedItem) => Padding(
                                                padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 5),
                                                child: Material(
                                                  elevation: 2,
                                                  child: ListTile(
                                                    leading: const Icon(Icons.circle, size: 8, color: Colors.black),
                                                    title: Text(
                                                      subBreedItem,
                                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => BreedDetailsScreen(
                                                                breedTitle: '$breedName/$subBreedItem'),
                                                          ));
                                                    },
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text("No data found"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

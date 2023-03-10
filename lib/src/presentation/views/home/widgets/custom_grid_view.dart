// Packages
import 'package:flutter/material.dart';
import 'package:universities/src/data/repositories_impl/universities_repository_impl.dart';
import 'package:universities/src/data/services/remote/get_university_service.dart';

// Models
import 'package:universities/src/domain/models/universities.dart';

// Universities
import 'package:universities/src/domain/repositories/universities_respository.dart';
import 'package:universities/src/presentation/views/detail/detail_page.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({super.key});

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  int lastId = 20;
  ScrollController scrollController = ScrollController();
  late UniversitiesRespository universitiesRespository;

  @override
  void initState() {
    universitiesRespository = UniversitiesRespositoryImpl(RemoteServices());
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        add();
      }
    });
    super.initState();
  }

  void add() {
    lastId = lastId + 20;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<University>>(
      future: universitiesRespository.getUniversities(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<University> universirties = snapshot.data!.sublist(0, lastId);
          return GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: universirties.length,
            itemBuilder: (context, index) {
              String firstLetter = universirties[index].name.substring(0, 1);
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: DetailArguments(
                    data: universirties[index],
                  ),
                ),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: Text(firstLetter),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        universirties[index].name,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const Text(
          'Ha ocurrido un error, por favor inténtalo de nuevo más tarde',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.3,
            color: Colors.black54,
            fontSize: 20,
          ),
        );
      },
    );
  }
}

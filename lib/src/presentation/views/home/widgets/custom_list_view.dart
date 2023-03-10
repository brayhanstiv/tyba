// Pacakages
import 'package:flutter/material.dart';

// Domain
import '../../../../domain/models/universities.dart';
import '../../../../domain/repositories/universities_respository.dart';

// Data
import '../../../../data/repositories_impl/universities_repository_impl.dart';
import '../../../../data/services/remote/get_university_service.dart';

// Pages
import '../../detail/detail_page.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
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
          return ListView.builder(
            controller: scrollController,
            itemCount: universirties.length,
            itemBuilder: (context, index) {
              String firstLetter = universirties[index].name.substring(0, 1);
              return ListTile(
                leading: CircleAvatar(
                  child: Text(firstLetter),
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: DetailArguments(
                    data: universirties[index],
                  ),
                ),
                title: Text(universirties[index].name),
                trailing: const Icon(Icons.arrow_forward_ios),
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

// Packages
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// Models
import 'package:universities/src/domain/models/universities.dart';
import 'package:universities/src/presentation/views/views.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    DetailArguments args =
        ModalRoute.of(context)!.settings.arguments as DetailArguments;

    University data = args.data!;
    // ignore: unused_local_variable
    late String numberStudents;

    void saveNumber(String value) {
      numberStudents = value;
    }

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'University Information: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  const TextSpan(
                    text: 'Name: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: data.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  const TextSpan(
                    text: 'Country: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: data.country,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Edit Information: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  args.imagePath == null
                      ? OutlinedButton(
                          onPressed: () async {
                            // Ensure that plugin services are initialized so that `availableCameras()`
                            // can be called before `runApp()`
                            WidgetsFlutterBinding.ensureInitialized();

                            // Obtain a list of the available cameras on the device.
                            final cameras = await availableCameras();

                            // Get a specific camera from the list of available cameras.
                            final firstCamera = cameras.first;
                            // ignore: use_build_context_synchronously
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TakePicturePage(
                                  camera: firstCamera,
                                  data: data,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.upload_file),
                              SizedBox(width: 10),
                              Text('Upload Image'),
                            ],
                          ),
                        )
                      : Image.file(
                          File(args.imagePath!),
                          width: 200,
                          height: 200,
                        ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('No Students'),
                    ),
                    onChanged: saveNumber,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (args.imagePath != null) {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        }
                      }
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text('Save'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailArguments {
  final University? data;
  final String? imagePath;

  DetailArguments({
    this.data,
    this.imagePath,
  });
}

import 'dart:developer';
import 'dart:io';

import 'package:contacts/ui/widgets/scaffold.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';



class Filepicker extends StatefulWidget {
  const Filepicker({Key? key}) : super(key: key);

  @override
  State<Filepicker> createState() => _FilepickerState();
}

class _FilepickerState extends State<Filepicker> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      heading: "File Upload",
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              label: const Text("Upload file"),
              icon: const Icon(Icons.upload_file),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  File file = File(result.files.single.path!);
                  try {
                    PdfDocument(
                        inputBytes: await File(file.path).readAsBytes());
                    log(file.path);
                  } catch (e) {
                    log("Please upload unprotected pdf file");
                  }
                } else {
                  // User canceled the picker
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

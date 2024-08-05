import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:test/api/pdf_api.dart';
import 'package:test/modals/pdf.dart';
import 'package:test/pages/pdf_viewer_page.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  String fileurl = "https://drive.google.com/file/d/1hXGzrEHZ3FfYR7lyLPjXJo-g7VXW4OkZ/view?usp=sharing";


   void downloadPdf() async {
    Map<Permission, PermissionStatus> statuses =
                                      await [
                                    Permission.storage,
                                    //add more permission to request here.
                                  ].request();

                                  if (statuses[Permission.storage]!.isGranted) {
                                    var dir = await DownloadsPathProvider
                                        .downloadsDirectory;
                                    if (dir != null) {
                                      String savename = "file.pdf";
                                      String savePath = dir.path + "/$savename";
                                      print(savePath);
                                      //output:  /storage/emulated/0/Download/banner.png

                                      try {
                                        await Dio().download(fileurl, savePath,
                                            onReceiveProgress:
                                                (received, total) {
                                          if (total != -1) {
                                            print((received / total * 100)
                                                    .toStringAsFixed(0) +
                                                "%");
                                            //you can build progressbar feature too
                                          }
                                        });
                                        print(
                                            "File is saved to download folder.");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("File Downloaded"),
                                        ));
                                      } on DioError catch (e) {
                                        print(e.message);
                                      }
                                    }
                                  } else {
                                    print("No permission to read and write.");
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Permission Denied !"),
                                    ));
                                  }
   }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' Note-Box',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: (width >= 700)
          ? ResponsiveGridList(
              minItemWidth: 300,
              children: List.generate(
                pdf.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Material(
                    elevation: 3,
                    shadowColor: Colors.grey,
                    child: ListTile(
                      minTileHeight: 100,
                      hoverColor: Colors.tealAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/images/sheet.png',
                                fit: BoxFit.cover),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: downloadPdf,
                                icon: const Icon(Icons.download_sharp,
                                    size: 30.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                pdf[index].department,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                "Semester: ${pdf[index].semester.toString()}",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(
                                height: 5,
                              ),
                          Text(
                            pdf[index].title,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                                height: 5,
                              ),
                          Row(children: [
                            Text(
                            pdf[index].year,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                                width: 50,
                              ),
                          Text(
                            pdf[index].category,
                            style: const TextStyle(fontSize: 15),
                          ),
                          ],),
                          const SizedBox(
                                height: 5,
                              ),
                          Text(
                            pdf[index].teacher,
                            style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          ),
                         
                        ],
                      ),
                      onTap: () async {
                        final path = 'assets/pdf/sample.pdf';
                        final file = await PDFApi.loadAsset(path);
                        openPDF(context, file);
                        //**firebase pdf open**
                        //  final url = 'sample.pdf';
                        // final file = await PDFApi.loadFirebase(url);

                        // if (file == null) return;
                        // openPDF(context, file);
                      },
                    ),
                  ),
                ),
              ),
              )
          : ListView.builder(
              itemCount: pdf.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Material(
                    elevation: 3,
                    shadowColor: Colors.grey,
                    child: ListTile(
                      minTileHeight: 70,
                      hoverColor: Colors.tealAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      leading: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/images/sheet.png',
                                fit: BoxFit.cover),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed:downloadPdf,
                                icon: const Icon(Icons.download_sharp,
                                    size: 30.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                pdf[index].department,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                "Semester: ${pdf[index].semester.toString()}",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Text(
                            pdf[index].title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Batch: ${pdf[index].year}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Text(
                                pdf[index].category,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text('By: ${pdf[index].teacher}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      onTap: () async {
                        final path = 'assets/pdf/sample.pdf';
                        final file = await PDFApi.loadAsset(path);
                        openPDF(context, file);
                        //  final url = 'sample.pdf';
                        // final file = await PDFApi.loadFirebase(url);

                        // if (file == null) return;
                        // openPDF(context, file);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}

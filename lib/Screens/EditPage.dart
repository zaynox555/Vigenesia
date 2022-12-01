import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:vigenesia/Constant/const.dart';
import 'package:vigenesia/Models/Motivasi_Model.dart';

class EditPage extends StatefulWidget {
  final String id;
  final String isi_motivasi;
  const EditPage({Key? key, required this.id, required this.isi_motivasi})
      : super(key: key);
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String baseurl = url;
  var dio = Dio();
  Future<dynamic> putPost(String isi_motivasi, String ids) async {
    Map<String, dynamic> data = {"isi_motivasi": isi_motivasi, "id": ids};
    var response = await dio.put('$baseurl/vigenesia/api/dev/PUTmotivasi',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ));
    print("---> ${response.data} + ${response.statusCode}");
    return response.data;
  }

  TextEditingController isiMotivasiC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: SafeArea(
          child: SizedBox(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${widget.isi_motivasi}"),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: FormBuilderTextField(
                    name: "isi_motivasi",
                    controller: isiMotivasiC,
                    decoration: const InputDecoration(
                      labelText: "New Data",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      putPost(isiMotivasiC.text, widget.id).then((value) => {
                            if (value != null)
                              {
                                Navigator.pop(context),
                                Flushbar(
                                  message: "Berhasil Update & Refresh dlu",
                                  duration: const Duration(seconds: 5),
                                  backgroundColor: Colors.green,
                                  flushbarPosition: FlushbarPosition.TOP,
                                ).show(context)
                              }
                          });
                    },
                    child: const Text("Submit"))
              ],
            ),
          ),
        ),
      )),
    );
  }
}

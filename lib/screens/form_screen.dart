import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final styleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มเพิ่มข้อมูล'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ชื่อ Vtuber',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(10),
                ),
                autofocus: false,
                controller: titleController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ชื่อค่าย',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(10),
                ),
                autofocus: false,
                controller: companyController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'แนวการสตรีม',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(10),
                ),
                autofocus: false,
                controller: styleController,
                validator: (String? str) {
                  if (str == null || str.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                ),
                child: const Text(
                  'บันทึก',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var statement = Transactions(
                      keyID: null,
                      title: titleController.text,
                      company: companyController.text,
                      style: styleController.text,
                      date: DateTime.now(),
                    );

                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);
                    provider.addTransaction(statement);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return MyHomePage();
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

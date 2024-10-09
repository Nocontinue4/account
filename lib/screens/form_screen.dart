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
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    styleController.dispose();
    super.dispose();
  }

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
              _buildTextField(titleController, 'ชื่อ Vtuber'),
              const SizedBox(height: 16),
              _buildTextField(companyController, 'สังกัดค่าย'),
              const SizedBox(height: 16),
              _buildTextField(styleController, 'แนวการสตรีม'),
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
                onPressed: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10),
      ),
      controller: controller,
      validator: (String? str) {
        if (str == null || str.isEmpty) {
          return 'กรุณากรอกข้อมูล';
        }
        return null;
      },
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      var statement = Transactions(
        keyID: null,
        title: titleController.text,
        company: companyController.text,
        style: styleController.text,
        date: DateTime.now(),
      );

      var provider = Provider.of<TransactionProvider>(context, listen: false);
      provider.addTransaction(statement);

      titleController.clear();
      companyController.clear();
      styleController.clear();

      Navigator.pop(context);
    }
  }
}

import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final Transactions statement;

  const EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final styleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.statement.title;
    companyController.text = widget.statement.company;
    styleController.text = widget.statement.style;
  }

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
        backgroundColor: Colors.lightBlue[400],
        title: const Text(
          'แบบฟอร์มแก้ไขข้อมูล',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: titleController,
                label: 'ชื่อ Vtuber',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: companyController,
                label: 'สังกัดค่าย',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: styleController,
                label: 'แนวการสตรีม',
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.lightBlue[400],
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                ),
                child: const Text(
                  'แก้ไขข้อมูล',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _onEditPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String label}) {
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

  void _onEditPressed() {
    if (formKey.currentState!.validate()) {
      var updatedStatement = Transactions(
        keyID: widget.statement.keyID,
        title: titleController.text,
        company: companyController.text,
        style: styleController.text,
        date: DateTime.now(),
      );

      var provider = Provider.of<TransactionProvider>(context, listen: false);
      provider.updateTransaction(updatedStatement);

      Navigator.pop(context);
    }
  }
}

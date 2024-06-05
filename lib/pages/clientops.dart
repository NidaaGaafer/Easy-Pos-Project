import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_easy_pos/helpers/sql_helpert.dart';
import 'package:my_easy_pos/models/clients_data.dart';
import 'package:my_easy_pos/widgets/button.dart';
import 'package:my_easy_pos/widgets/textfiled.dart';

class ClientOpsPage extends StatefulWidget {
  ClientOpsPage({super.key});

  @override
  State<ClientOpsPage> createState() => _ClientOpsPageState();
}

class _ClientOpsPageState extends State<ClientOpsPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clint Information')),
      body: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              AppTextField(
                label: 'Name',
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Name";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              AppTextField(
                label: 'Email',
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Email";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              AppTextField(
                label: 'Phone',
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Phone";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              MyButton(
                description: 'Add Client',
                onPressed: () async {
                  await addClient();
                },
              )
            ],
          )),
    );
  }

  Future<void> addClient() async {
    try {
      if (formKey.currentState!.validate()) {
        var sqlHelper = GetIt.I.get<SqlHelpert>();
        await sqlHelper.db!.insert('clients', {
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success Adding Operation'),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Success Adding Operation'),
        backgroundColor: Colors.red,
      ));
    }
  }
}

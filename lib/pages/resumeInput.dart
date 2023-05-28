// create an app that will take user details such as name,
// profile, experience, jobs, and education as input and then
// generate a resume

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:task1/controller/resume-input-controller.dart';
import 'package:task1/models/generalInfoModel.dart';
import 'package:task1/widgets/customTextField.dart';

import 'addExperience.dart';

class ResumeInput extends StatelessWidget {
  ResumeInput({super.key});
  final ResumeController resumeController = Get.put(ResumeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Builder"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: resumeController.generalFormKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: "Name",
                      controller: resumeController.nameController,
                    ),
                    CustomTextFormField(
                      labelText: "Email",
                      controller: resumeController.emailController,
                    ),
                    CustomTextFormField(
                      labelText: "Phone Number",
                      controller: resumeController.phoneController,
                    ),
                    CustomTextFormField(
                      labelText: "Address",
                      controller: resumeController.addressController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Get.toNamed("/resume-input/add-experience");
                  if (resumeController.generalFormKey.currentState!
                      .validate()) {
                    Get.toNamed(
                      "/resume-input/add-experience",
                      arguments: {
                        "generalDetails": GeneralInfoModel(
                          name: resumeController.nameController.text,
                          email: resumeController.emailController.text,
                          phoneNo: resumeController.phoneController.text,
                          address: resumeController.addressController.text,
                        )
                      },
                    );
                  }
                },
                child: Text("Add General Info"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

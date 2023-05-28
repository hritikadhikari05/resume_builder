import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:task1/controller/resume-input-controller.dart';
import 'package:task1/widgets/customButton.dart';

import '../models/educationModel.dart';
import '../widgets/customTextField.dart';

class AddEducation extends StatelessWidget {
  AddEducation({super.key});
  final ResumeController resumeController = Get.put(ResumeController());
  @override
  Widget build(BuildContext context) {
    final argumentData = Get.arguments;
    log("Argument Data Edu: ${argumentData}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Education"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Column(
                    children: resumeController.education.map<Widget>(
                      (education) {
                        return Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      education.educationName ?? "",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      education.educationDescription ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Icon(Icons.clear),
                              IconButton(
                                onPressed: () {
                                  resumeController.education.remove(education);
                                },
                                icon: const Icon(Icons.clear),
                              )
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Form(
                  key: resumeController.educationFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: "Education Title",
                        controller: resumeController.educationController,
                      ),
                      CustomTextFormField(
                        labelText: "Education Description",
                        controller:
                            resumeController.educationDescriptionController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonText: "Add Education",
                  onPressed: () {
                    if (resumeController.educationFormKey.currentState!
                        .validate()) {
                      resumeController.educationFormKey.currentState!.save();
                      resumeController.education.add(
                        EducationModel(
                          educationName:
                              resumeController.educationController.text,
                          educationDescription: resumeController
                              .educationDescriptionController.text,
                        ),
                      );
                      resumeController.educationController.clear();
                      resumeController.educationDescriptionController.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            "/resume-input/verify-details",
            arguments: {
              "generalInfo": argumentData["generalInfo"],
              "experiences": argumentData["experiences"],
              "jobs": argumentData["jobs"],
              "education": resumeController.education,
            },
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:task1/controller/resume-input-controller.dart';
import 'package:task1/models/experienceModel.dart';
import 'package:task1/pages/addJobs.dart';
import 'package:task1/widgets/customButton.dart';

import '../widgets/customTextField.dart';

class AddExperience extends StatelessWidget {
  AddExperience({super.key});
  final ResumeController resumeController = ResumeController();
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    log("Resume Controller: ${arguments}");
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Experience",
          ),
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
                      children: resumeController.experiences.map<Widget>(
                        (experience) {
                          return Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        experience.experienceName ?? "",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        experience.experienceDescription ?? "",
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
                                    resumeController.experiences
                                        .remove(experience);
                                  },
                                  icon: Icon(Icons.clear),
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Form(
                    key: resumeController.experienceFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: "Experience",
                          controller: resumeController.experienceController,
                        ),
                        CustomTextFormField(
                          labelText: "Experience Description",
                          controller:
                              resumeController.experienceDescriptionController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: "Add Experience",
                    onPressed: () {
                      if (resumeController.experienceFormKey.currentState!
                          .validate()) {
                        resumeController.experienceFormKey.currentState!.save();
                        resumeController.experiences.add(
                          ExperienceModel(
                            experienceName:
                                resumeController.experienceController.text,
                            experienceDescription: resumeController
                                .experienceDescriptionController.text,
                          ),
                        );
                        resumeController.experienceController.clear();
                        resumeController.experienceDescriptionController
                            .clear();
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
            Get.toNamed("/resume-input/add-jobs", arguments: {
              "generalInfo": arguments["generalDetails"],
              "experiences": resumeController.experiences,
            });
          },
          child: Icon(Icons.arrow_forward),
        ));
  }
}

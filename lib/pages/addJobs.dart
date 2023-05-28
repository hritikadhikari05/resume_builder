import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:task1/controller/resume-input-controller.dart';
import 'package:task1/models/jobsModel.dart';
import 'package:task1/widgets/customButton.dart';

import '../models/experienceModel.dart';
import '../widgets/customTextField.dart';

class AddJobs extends StatelessWidget {
  AddJobs({super.key});
  ResumeController resumeController = Get.put(ResumeController());
  @override
  Widget build(BuildContext context) {
    final argumentData = Get.arguments;
    log("Resume Controller job: ${argumentData}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Jobs"),
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
                    children: resumeController.jobs.map<Widget>(
                      (job) {
                        return Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      job.jobsName ?? "",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      job.jobsDescription ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Icon(Icons.clear),
                              IconButton(
                                onPressed: () {
                                  resumeController.jobs.remove(job);
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
                  key: resumeController.jobsFormKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: "Job Title",
                        controller: resumeController.jobsController,
                      ),
                      CustomTextFormField(
                        labelText: "Jobs Description",
                        controller: resumeController.jobsDescriptionController,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonText: "Add Jobs",
                  onPressed: () {
                    if (resumeController.jobsFormKey.currentState!.validate()) {
                      resumeController.jobsFormKey.currentState!.save();
                      resumeController.jobs.add(
                        JobsModel(
                          jobsName: resumeController.jobsController.text,
                          jobsDescription:
                              resumeController.jobsDescriptionController.text,
                        ),
                      );
                      resumeController.jobsController.clear();
                      resumeController.jobsDescriptionController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/resume-input/add-education", arguments: {
            "generalInfo": argumentData["generalInfo"],
            "experiences": argumentData["experiences"],
            "jobs": resumeController.jobs,
          });
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

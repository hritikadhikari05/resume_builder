import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:task1/resume.dart';

class VerifyDetails extends StatelessWidget {
  const VerifyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final argumentData = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verify Details",
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Generate simple resume desing for verification
            Align(
              alignment: Alignment.center,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 58,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      "${argumentData['generalInfo'].name}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* General Info */
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text("Name: ${argumentData['generalInfo'].name}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text("Email: ${argumentData['generalInfo'].email}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child:
                  Text("Phone Number: ${argumentData['generalInfo'].phoneNo}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text("Address: ${argumentData['generalInfo'].address}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),

            /* Experiences */

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text("Experience:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Column(
              children: argumentData['experiences'].map<Widget>((experience) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${experience.experienceName}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(" - ${experience.experienceDescription}",
                          style: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                );
              }).toList(),
            ),

            /* Education */
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text("Education:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Column(
              children: argumentData['education'].map<Widget>((experience) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${experience.educationName}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(" - ${experience.educationDescription}",
                          style: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                );
              }).toList(),
            ),

            /* Jobs */
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text("Jobs:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),

            Column(
              children: argumentData['jobs'].map<Widget>((experience) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${experience.jobsName}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(" - ${experience.jobsDescription}",
                          style: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                );
              }).toList(),
            ),

            /* Generate Resume */
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed("/generate-resume", arguments: argumentData);
                },
                child: const Text("Generate Resume"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

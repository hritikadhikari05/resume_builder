import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/models/experienceModel.dart';

class ResumeController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController experienceDescriptionController =
      TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController educationDescriptionController =
      TextEditingController();
  TextEditingController jobsController = TextEditingController();
  TextEditingController jobsDescriptionController = TextEditingController();

  //General Form Key
  GlobalKey<FormState> generalFormKey = GlobalKey<FormState>();

  //Experiences
  RxList experiences = [].obs;

  //Experience Form Key
  GlobalKey<FormState> experienceFormKey = GlobalKey<FormState>();

  //Jobs
  RxList jobs = [].obs;

  //Jobs Form Key
  GlobalKey<FormState> jobsFormKey = GlobalKey<FormState>();

  //Education
  RxList education = [].obs;

  //Education Form Key
  GlobalKey<FormState> educationFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    nameController.dispose();
    experienceController.dispose();
    experienceDescriptionController.dispose();
    educationController.dispose();
    educationDescriptionController.dispose();
    jobsController.dispose();
    jobsDescriptionController.dispose();

    super.onClose();
  }
}

import 'package:get/get.dart';
import 'package:task1/pages/addEducation.dart';
import 'package:task1/pages/addExperience.dart';
import 'package:task1/pages/addJobs.dart';
import 'package:task1/pages/resumePdf.dart';
import 'package:task1/pages/verifyDetails.dart';

import '../pages/resumeInput.dart';

appRoutes() => [
      GetPage(
        name: '/resume-input',
        page: () => ResumeInput(),
        children: [
          GetPage(
            name: '/add-experience',
            page: () => AddExperience(),
          ),
          GetPage(
            name: '/add-jobs',
            page: () => AddJobs(),
          ),
          GetPage(
            name: '/add-education',
            page: () => AddEducation(),
          ),
          GetPage(
            name: '/verify-details',
            page: () => VerifyDetails(),
          ),
        ],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(name: "/generate-resume", page: () => ResumePDF())
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}

import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/profile/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    super.key,
    required this.fullNameController,
    required this.dobController,
    required this.emailController,
    required this.phoneController,
    required this.studentController,
    required this.selectedGender,
    required this.genderList,
    required this.onGenderChanged,
  });

  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController studentController;
  final String? selectedGender;
  final List<String> genderList;
  final Function(String?) onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileCard(
          isCameraEnabled: true,
        ),
        Gap(20),
        CustomTextField(
          controller: fullNameController,
          hintText: 'Full Name',
        ),
        Gap(12),
        CustomTextField(
          controller: dobController,
          hintText: 'Date of birth',
          prefixIcon:
              SvgPicture.asset(AppAssets.calendarSvg, width: 17, height: 17),
        ),
        Gap(12),
        CustomTextField(
          controller: emailController,
          hintText: 'Email',
          prefixIcon:
              SvgPicture.asset(AppAssets.emailSvg, width: 20, height: 20),
        ),
        Gap(12),
        CustomTextField(
          controller: phoneController,
          hintText: 'Enter your phone',
        ),
        Gap(12),
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedGender,
              hint: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'Choose Gender',
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              items: genderList
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: onGenderChanged,
            ),
          ),
        ),
        Gap(12),
        CustomTextField(
          controller: studentController,
          hintText: 'Student',
        ),
      ],
    );
  }
}

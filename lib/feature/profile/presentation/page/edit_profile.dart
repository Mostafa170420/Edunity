import 'package:edunity/components/buttons/main_button.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/profile/presentation/widgets/profile_form.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController studentController = TextEditingController();

  // Dropdown values
  String? selectedGender;
  final List<String> genderList = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyles.getTitle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ProfileForm(
          fullNameController: fullNameController,
          dobController: dobController,
          emailController: emailController,
          phoneController: phoneController,
          studentController: studentController,
          selectedGender: selectedGender,
          genderList: genderList,
          onGenderChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: MainButton(
          title: 'Update',
          onPressed: () {},
        ),
      ),
    );
  }
}

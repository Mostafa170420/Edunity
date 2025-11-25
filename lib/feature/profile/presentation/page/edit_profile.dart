// Import necessary packages and widgets for the edit profile screen.
import 'package:edunity/components/buttons/main_button.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/profile/presentation/widgets/profile_form.dart';
import 'package:flutter/material.dart';

/// The `EditProfile` screen is a stateful widget that allows users to modify their
/// profile information. It provides a form with various fields for user data input.
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Controllers for the text fields in the profile form.
  // In a real app, these would be initialized with the user's current data.
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController studentController = TextEditingController();

  // State for the gender selection dropdown.
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
        automaticallyImplyLeading: true, // Provides a back button.
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      // The body is scrollable to prevent overflow on smaller screens.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        // `ProfileForm` is a reusable widget containing the form fields.
        child: ProfileForm(
          fullNameController: fullNameController,
          dobController: dobController,
          emailController: emailController,
          phoneController: phoneController,
          studentController: studentController,
          selectedGender: selectedGender,
          genderList: genderList,
          // This callback updates the state when the user selects a new gender.
          onGenderChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
      ),
      // The bottom bar holds the action button for the form.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: MainButton(
          title: 'Update',
          onPressed: () {
            // Note: The update logic is not implemented. In a real app, this would
            // validate the form and save the updated user data.
          },
        ),
      ),
    );
  }
}

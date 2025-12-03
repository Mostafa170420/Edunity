// Import necessary packages and widgets for the edit profile screen.
import 'dart:developer';
import 'dart:io';

import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/buttons/main_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/extentions/dialogs.dart';
import 'package:edunity/core/extentions/image_uploader.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:edunity/feature/profile/presentation/bloc/profile_event.dart';
import 'package:edunity/feature/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

/// The `EditProfile` screen is a stateful widget that allows users to modify their
/// profile information. It provides a form with various fields for user data input.
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _imagePath;
  File? file;
  @override
  void initState() {
    final bloc = context.read<ProfileBloc>();
    super.initState();
    bloc.add(ProfileLoadEvent());
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProfileBloc>();

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          log('loading');
          showLoadingDialog(context);
        } else if (state is ProfileErrorState) {
          pop(context);
          showMyDialoge(context, state.message ?? 'An error occurred');
        } else if (state is ProfileSuccessState) {
          pop(context);
          if (state.message != null) {
            showMyDialoge(context, state.message!, type: DialogeType.success);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style:
                TextStyles.getTitle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          automaticallyImplyLeading: true, // Provides a back button.
          elevation: 0,
        ),
        // The body is scrollable to prevent overflow on smaller screens.
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryLightColor,
                                AppColors.primaryDarkColor,
                              ],
                              transform:
                                  const GradientRotation(90 * 3.14 / 180),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: _imagePath != null
                                ? FileImage(File(_imagePath!))
                                : (SharedPref.getUserImage() ?? '').isNotEmpty
                                    ? NetworkImage(
                                            SharedPref.getUserImage() ?? '')
                                        as ImageProvider
                                    : NetworkImage(
                                        bloc.imageUrl ?? AppAssets.defaultUser),
                          ),
                        ),
                        Gap(50)
                      ],
                    ),
                    Positioned(
                      top: 100,
                      right: 0,
                      child: GradientButton(
                        label: '',
                        onPressed: _pickImage,
                        width: 40,
                        icon: SvgPicture.asset(
                          AppAssets.cameraSvg,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                              AppColors.whiteColor, BlendMode.srcIn),
                        ),
                        iconAlignment: IconAlignment.start,
                      ),
                    ),
                  ],
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.fullNameController,
                  hintText: 'Full Name',
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.bioController,
                  hintText: 'Bio...',
                  maxLines: 3,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.dobController,
                  onTap: () => pickDate(context, bloc.dobController),
                  hintText: 'Date of birth',
                  readOnly: true,
                  prefixIcon: SvgPicture.asset(AppAssets.calendarSvg,
                      width: 17, height: 17),
                ),
              ],
            )),
        // The bottom bar holds the action button for the form.
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24),
          child: MainButton(
            title: 'Update',
            onPressed: () async {
              if (file != null) {
                bloc.imageUrl = await uploadImageToCloudinary(file!) ?? '';
                SharedPref.setUserImage(bloc.imageUrl ?? AppAssets.defaultUser);
              } else {
                bloc.imageUrl = SharedPref.getUserImage() ?? '';
              }
              bloc.add(UpdateProfileEvent());
            },
          ),
        ),
      ),
    );
  }
}

Future<void> pickDate(
    BuildContext context, TextEditingController controller) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (date != null) {
    controller.text = "${date.year}-${date.month}-${date.day}";
  }
}

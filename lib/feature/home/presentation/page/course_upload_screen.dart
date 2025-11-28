import 'dart:developer';

import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/extentions/dialogs.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/feature/home/presentation/bloc/home_bloc.dart';
import 'package:edunity/feature/home/presentation/bloc/home_event.dart';
import 'package:edunity/feature/home/presentation/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class TeacherAddCourseScreen extends StatefulWidget {
  const TeacherAddCourseScreen({super.key});

  @override
  State<TeacherAddCourseScreen> createState() => _TeacherAddCourseScreenState();
}

class _TeacherAddCourseScreenState extends State<TeacherAddCourseScreen> {
  final List<TextEditingController> videoLinks = [TextEditingController()];

  void addVideoField() {
    setState(() {
      videoLinks.add(TextEditingController());
    });
  }

  void removeVideoField(int index) {
    setState(() {
      videoLinks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HomeBloc>();
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          log('loading');
          showLoadingDialog(context);
        } else if (state is HomeErrorState) {
          pop(context);
          showMyDialoge(context, state.message ?? 'An error occurred');
        } else if (state is HomeSuccessState) {
          pop(context);
          if (state.message != null) {
            showMyDialoge(context, state.message!, type: DialogeType.success);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Course"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: bloc.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: bloc.categoryController,
                  label: const Text("Category"),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Category'
                      : null,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.durationController,
                  label: const Text("Duration"),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Duration'
                      : null,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.instructorController,
                  label: const Text("Instructor"),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Instructor'
                      : null,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.languageController,
                  label: const Text("Language"),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Language'
                      : null,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.levelController,
                  label: const Text("Level"),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Level'
                      : null,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.nameController,
                  label: const Text("Course Name"),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Course Name'
                      : null,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.numVideosController,
                  label: const Text("Number of Videos"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Number of Videos'
                      : null,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.ratingController,
                  label: const Text("Rating"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Rating'
                      : null,
                ),
                Gap(15),
                CustomTextField(
                  controller: bloc.thumbnailController,
                  label: const Text("Thumbnail URL"),
                  keyboardType: TextInputType.text,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter Thumbnail URL'
                      : null,
                ),
                Gap(15),
                const SizedBox(height: 20),
                const Text(
                  "Video Links",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: videoLinks.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: videoLinks[index],
                            label: Text("Video Link ${index + 1}"),
                            keyboardType: TextInputType.text,
                            validator: (value) => value == null || value.isEmpty
                                ? "Please enter Video Link ${index + 1}"
                                : null,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: videoLinks.length > 1
                              ? () => removeVideoField(index)
                              : null,
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: addVideoField,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Another Video Link"),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (bloc.formKey.currentState!.validate()) {
                        bloc.add(CourseUploadEvent());
                      }
                    },
                    child: const Text("Submit Course"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

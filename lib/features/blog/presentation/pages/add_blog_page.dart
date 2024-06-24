import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/common/widgets/loader.dart';
import 'package:flutter_blog_app/core/cubits/cubit/app_user_cubit.dart';
import 'package:flutter_blog_app/core/theme/app_pallet.dart';
import 'package:flutter_blog_app/core/utils/pick_image.dart';
import 'package:flutter_blog_app/core/utils/snack_bar.dart';
import 'package:flutter_blog_app/features/auth/presentation/widgets/auth_custom_button.dart';
import 'package:flutter_blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter_blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:flutter_blog_app/features/blog/presentation/widgets/color_editor.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddBlogPage());
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final blogTitleController = TextEditingController();
  final contentController = TextEditingController();
  File? image;
  Color selectedColor = AppPallete.whiteColor;

  List<String> selectedCategories = [];

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    blogTitleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(selectedColor.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog'),
        actions: [
          IconButton(
              onPressed: () {
                if (formkey.currentState!.validate() &&
                    selectedCategories.isNotEmpty &&
                    image != null) {
                  final posterId =
                      (context.read<AppUserCubit>().state as AppUserLoggedIn)
                          .user!
                          .id;
                  context.read<BlogBloc>().add(UploadBlogEvent(
                      posterId: posterId,
                      title: blogTitleController.text.trim(),
                      content: contentController.text.trim(),
                      image: image!,
                      topics: selectedCategories,
                      color: selectedColor.value));
                }
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
          if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
                context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ))))
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                                color: AppPallete.borderColor,
                                radius: const Radius.circular(15),
                                dashPattern: const [10, 4],
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: const SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Select your Image',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: [
                        'Tech',
                        'Business',
                        'Fashion',
                        'Design',
                        'Sports',
                        'Entertainment'
                      ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedCategories.contains(e)) {
                                          selectedCategories.remove(e);
                                        } else {
                                          selectedCategories.add(e);
                                        }

                                        setState(() {});
                                      },
                                      child: Chip(
                                          color: selectedCategories.contains(e)
                                              ? const WidgetStatePropertyAll(
                                                  AppPallete.gradient1)
                                              : null,
                                          side: selectedCategories.contains(e)
                                              ? null
                                              : const BorderSide(
                                                  color:
                                                      AppPallete.borderColor),
                                          label: Text(e)),
                                    ),
                                  ))
                              .toList()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlogEditor(
                        controller: blogTitleController,
                        hintText: 'Blog title'),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogEditor(
                        controller: contentController,
                        hintText: 'Type your content ... '),
                    const SizedBox(
                      height: 10,
                    ),
                    ColorEditor(
                        text: 'Select color',
                        ontap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('pick a color'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ColorPicker(
                                            pickerColor: selectedColor,
                                            onColorChanged: (value) {
                                              setState(() {
                                                selectedColor = value;
                                              });
                                            }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AuthCustomButton(
                                            text: 'save',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        selectedColor: selectedColor)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

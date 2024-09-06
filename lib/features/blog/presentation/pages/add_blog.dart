import 'dart:io';
import 'dart:math';

import 'package:blog/core/theme/app_colors.dart';
import 'package:blog/core/utils/image_picker.dart';
import 'package:blog/features/blog/presentation/widgets/blog_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBlogScreen extends StatefulWidget {
  static rout() => MaterialPageRoute(
        builder: (context) => const AddBlogScreen(),
      );

  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final TextEditingController _blogTitleController = TextEditingController();
  final TextEditingController _blogDescriptionController =
      TextEditingController();
  File? image;
  List selectedTopics = [];

  void pickImage() async {
    final pickedImage = await getImage();
    if (pickedImage != null) {
      setState(() {

        image = pickedImage;
        print(image);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _blogDescriptionController.dispose();
    _blogTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.done_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: DottedBorder(
                    color: AppPallete.borderColor,
                    dashPattern: const [10, 4],
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    strokeCap: StrokeCap.round,
                    child: const SizedBox(
                      width: double.infinity,
                      height: 150,
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
                            'Add Your Image',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      'technology',
                      'business',
                      'entertainment',
                      'sports',
                    ]

                        ///by using this map in the row children we can access each one of
                        ///children using e of the map and do the operations
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(e)) {
                                  selectedTopics.remove(e);
                                } else {
                                  selectedTopics.add(e);
                                }

                                ///set state for rebuilding after clicking on each tab bar item
                                setState(() {});
                              },
                              child: Chip(
                                color: selectedTopics.contains(e)
                                    ? const MaterialStatePropertyAll(
                                        AppPallete.gradient1)
                                    : null,
                                label: Text(
                                  e,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                side: selectedTopics.contains(e)
                                    ? null
                                    : const BorderSide(
                                        color: AppPallete.borderColor),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlogScreenTextField(
                    controller: _blogTitleController, hintText: 'Blog title'),
                const SizedBox(
                  height: 20,
                ),
                BlogScreenTextField(
                    controller: _blogDescriptionController,
                    hintText: 'Blog title'),
              ],
            ),
          ),
        ));
  }
}

import 'package:blog/core/theme/app_colors.dart';
import 'package:blog/core/utils/format_date_time.dart';
import 'package:blog/core/utils/reading_time.dart';
import 'package:blog/core/widgets/custom_app_bar.dart';
import 'package:blog/features/blog/domain/entity/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogDetailPage extends StatelessWidget {
  //we can get what ever we want from the page that we are
  //going to navigate from to here , by taking it through
  //this static methode made for easier navigation code to prevent boiler plate
  static rout(BlogEntity blog) => MaterialPageRoute(
        builder: (context) => BlogDetailPage(
          blog: blog,
        ),
      );
  final BlogEntity blog;

  const BlogDetailPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'by ${blog.name}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${formatDatetime(blog.updatedAt)} . ${readingTimeCalculator(blog.content)} min',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  blog.content,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

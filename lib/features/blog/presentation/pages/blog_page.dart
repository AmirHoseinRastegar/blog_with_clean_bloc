import 'package:blog/core/constants/loader.dart';
import 'package:blog/core/theme/app_colors.dart';
import 'package:blog/core/utils/snakbar.dart';
import 'package:blog/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:blog/features/blog/presentation/pages/add_blog_page.dart';
import 'package:blog/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static rout() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetALlBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddBlogScreen.rout());
            },
            icon: const Icon(
              CupertinoIcons.add_circled,
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogUploadError) {
            return snakBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const AppLoader();
          } else if (state is BlogGetALlBlogsSuccess) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];

                return BlogCard(
                  blog: blog,
                  color: index % 3 == 0
                      ? AppPallete.gradient1
                      : index % 3 == 1
                          ? AppPallete.gradient2
                          : AppPallete.gradient3,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

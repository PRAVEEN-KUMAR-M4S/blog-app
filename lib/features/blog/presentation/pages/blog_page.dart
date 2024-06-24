import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/common/widgets/loader.dart';
import 'package:flutter_blog_app/core/utils/snack_bar.dart';
import 'package:flutter_blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/add_blog_page.dart';
import 'package:flutter_blog_app/features/blog/presentation/pages/blog_view_page.dart';
import 'package:flutter_blog_app/features/blog/presentation/widgets/custom_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Hub', style: TextStyle(fontSize: 16)),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, AddBlogPage.route()),
              icon: const Icon(CupertinoIcons.add_circled))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const Divider(color: Colors.grey, thickness: 0.6),
            Expanded(
              child: BlocConsumer<BlogBloc, BlogState>(
                listener: (context, state) {
                  if (state is BlogFailure) {
                    return showSnackBar(context, state.error);
                  }
                },
                builder: (context, state) {
                  if (state is BlogLoading) {
                    return const Loader();
                  }
                  if (state is BlogFetchSuccess) {
                    return ListView.builder(
                        itemCount: state.blogs.length,
                        itemBuilder: (context, index) {
                          final blog = state.blogs[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, BlogViewPage.route(blog));
                            },
                            child: CustomCard(
                              blog: blog,
                            ),
                          );
                        });
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

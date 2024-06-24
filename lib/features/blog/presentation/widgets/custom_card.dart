import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/utils/calculate_time.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';

class CustomCard extends StatelessWidget {
  final Blog blog;

  const CustomCard({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
   
    return Container(
      alignment: Alignment.bottomCenter,
      height: 250,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Color(blog.color)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: blog.topics
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Chip(
                                      label: Text(
                                    e,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  )),
                                ))
                            .toList()),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: const Center(child: Icon(Icons.bookmark)),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                blog.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ],
          ),
          Text(
            '${calCulateReadingTime(blog.content)} min',
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_pallet.dart';
import 'package:flutter_blog_app/core/utils/calculate_time.dart';
import 'package:flutter_blog_app/core/utils/formate_date.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';

class BlogViewPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
      builder: (context) => BlogViewPage(
            blog: blog,
          ));
  final Blog blog;
  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
        backgroundColor: AppPallete.transparentColor,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal:24,vertical:14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: blog.topics.map((e) => Container(margin: const EdgeInsets.only(right: 10),padding: const EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(blog.color)),child: Text(e,style: const TextStyle(color:AppPallete.backgroundColor,fontWeight: FontWeight.w300),))).toList(),
                ),
                const SizedBox(height: 10,),
                Text(blog.title,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                const SizedBox(height: 20,),
                Text('By ${blog.posterId}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                const SizedBox(height: 5,),
                Text('${formateDateBydMMMyyyy(blog.updatedAt)} . ${calCulateReadingTime(blog.content)} min',style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 12,color: AppPallete.greyColor),),
                const SizedBox(height: 10,),
                ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(blog.imgUrl,fit: BoxFit.cover,)),
                const SizedBox(height: 20,),
                Text(blog.content,style: const TextStyle(fontSize: 16,height: 2),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

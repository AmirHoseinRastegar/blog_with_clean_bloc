import 'package:hive/hive.dart';

import '../../models/blog_model.dart';

abstract interface class LocalBlogDataSource {
  void uploadBlogs({required List<BlogModel> blogs});

  List<BlogModel> loadBlogs();
}

class LocalBlogDataSourceImpl implements LocalBlogDataSource {
  final Box box;

  LocalBlogDataSourceImpl({required this.box});

  ///load blogs from local storage to show it in ui when app starts
  /// and user has no network connection
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    print(blogs);
    return blogs;
  }

  ///upload blogs is used when we want to upload the loaded data from
  ///supabase to local storage so that when user has no network connection
  ///when app starts it gets stored again and again so that we can call load blogs function
  ///when we have no connection to load the stored data from local storage
  @override
  void uploadBlogs({required List<BlogModel> blogs}) {
    ///to clear stored stuff from before because otherwise
    ///whenever we open app it gets stored again and again
    box.clear();
    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}

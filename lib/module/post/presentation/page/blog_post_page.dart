import 'package:blogpost/core/widget/bw_icon_button.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:blogpost/module/post/presentation/state/posts/posts_bloc.dart';
import 'package:blogpost/module/post/presentation/widget/bw_tab_bar.dart';
import 'package:blogpost/module/post/presentation/widget/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PostsLoadingStatus {
  loading,
  failure,
  success
}

class BlogPostPage extends StatefulWidget {

  final PostInteractor postInteractor;
  final bool isAuthorized;

  const BlogPostPage({
    super.key,
    required this.postInteractor,
    required this.isAuthorized
  });

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage>
    with TickerProviderStateMixin {

  late TabController _tabController;

  PostsLoadingStatus allPostsStatus = PostsLoadingStatus.loading;
  String? errorMessageForAllPosts;
  List<Post> allPosts = [];
  List<Post>? allPostsSearched;

  PostsLoadingStatus? myPostsStatus;
  String? errorMessageForMyPosts;
  List<Post>? myPosts;
  List<Post>? myPostsSearched;

  void fetchAllPosts() async {
    setState(() {
      allPostsStatus = PostsLoadingStatus.loading;
    });
    try {
      allPosts = await widget.postInteractor.getAllPosts();
      setState(() {
        allPostsStatus = PostsLoadingStatus.success;
      });
    } catch (e) {
      errorMessageForAllPosts = e.toString();
      setState(() {
        allPostsStatus = PostsLoadingStatus.failure;
      });
    }
  }

  void fetchMyPosts() async {
    setState(() {
      myPostsStatus = PostsLoadingStatus.loading;
    });
    try {
      myPosts = await widget.postInteractor.getMyPosts();
      setState(() {
        myPostsStatus = PostsLoadingStatus.success;
      });
    } catch (e) {
      errorMessageForMyPosts = e.toString();
      setState(() {
        myPostsStatus = PostsLoadingStatus.failure;
      });
    }
  }

  void onQueryChanged(String query){
    if(widget.isAuthorized){
      if(_tabController.index == 0){
        if(query.isNotEmpty){
          setState(() {
            myPostsSearched = myPosts!.where((post) => post.title.toLowerCase().contains(query.toLowerCase())).toList();
            allPostsSearched = null;
          });
        } else {
          setState(() {
            myPostsSearched = null;
          });
        }
      } else {
        if(query.isNotEmpty){
          setState(() {
            allPostsSearched = allPosts.where((post) => post.title.toLowerCase().contains(query.toLowerCase())).toList();
            myPostsSearched = null;
          });
        } else {
          setState(() {
            allPostsSearched = null;
          });
        }
      }
    } else {
      if(_tabController.index == 0){
        if(query.isNotEmpty){
          setState(() {
            allPostsSearched = allPosts.where((post) => post.title.toLowerCase().contains(query.toLowerCase())).toList();
          });
        } else {
          setState(() {
            allPostsSearched = null;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.isAuthorized ? 2 : 1, vsync: this);
    fetchAllPosts();
    if(widget.isAuthorized){
      fetchMyPosts();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: widget.isAuthorized
          ? BwIconButton(
              iconData: Icons.add,
              onPressed: () {
                Navigator.pushNamed(context, "/edit_post");
              },
            )
          : null,
      appBar: AppBar(
        title: const Text("BlogPost"),
        actions: widget.isAuthorized ?[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/settings");
            },
            icon: const Icon(Icons.settings),
          ),
        ] : null,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: 
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchBar(
              elevation: MaterialStatePropertyAll(0),
              hintText: "Type post name",
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  side: BorderSide(color: Colors.black))),
              leading: Icon(Icons.search),
              onChanged: onQueryChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            BWTabBar(
                tabController: _tabController,
                options:
                    widget.isAuthorized ? ["My posts", "All posts"] : ["All posts"]
                    ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                  children: [
                    if(widget.isAuthorized)
                    RefreshIndicator(
                      color: Colors.black,
                      onRefresh: () async {
                        fetchMyPosts();
                      },
                      child: Center(
                        child: SingleChildScrollView(
                          child: Builder(
                            builder: (context){
                              if(myPostsStatus == PostsLoadingStatus.loading){
                                return const CircularProgressIndicator(
                                  color: Colors.black,
                                );
                              } else if(myPostsStatus == PostsLoadingStatus.success){
                                if(myPostsSearched != null){
                                  return PostsList(posts: myPostsSearched!);
                                } else {
                                  return PostsList(posts: myPosts!..sort((a, b) => b.date.compareTo(a.date)));
                                }
                              } else {
                                return const Placeholder();
                              }
                            }
                          ),
                        ),
                      )
                    ),
                    RefreshIndicator(
                      color: Colors.black,
                      onRefresh: () async {
                        fetchAllPosts();
                      },
                      child: Center(
                        child: SingleChildScrollView(
                          child: Builder (
                            builder: (context){
                              if(allPostsStatus == PostsLoadingStatus.loading){
                                return const CircularProgressIndicator(
                                  color: Colors.black,
                                );
                              } else if(allPostsStatus == PostsLoadingStatus.success){
                                if(allPostsSearched != null){
                                  return PostsList(posts: allPostsSearched!);
                                } else {
                                  return PostsList(posts: allPosts..sort((a, b) => b.date.compareTo(a.date)));
                                }
                              } else {
                                return const Placeholder();
                              }
                            }
                          ),
                        ),
                      )
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

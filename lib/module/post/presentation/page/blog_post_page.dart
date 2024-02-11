import 'package:blogpost/core/widget/bw_icon_button.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/post/presentation/state/posts/posts_bloc.dart';
import 'package:blogpost/module/post/presentation/widget/bw_tab_bar.dart';
import 'package:blogpost/module/post/presentation/widget/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPostPage extends StatefulWidget {
  const BlogPostPage({super.key});

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    final isAuthorized =
        authBloc.state is AuthAuthorizedState;

    final tabController =
        TabController(length: isAuthorized ? 2 : 1, vsync: this);

    return Scaffold(
      floatingActionButton: isAuthorized
          ? BwIconButton(
              iconData: Icons.add,
              onPressed: () {
                Navigator.pushNamed(context, "/edit_post");
              },
            )
          : null,
      appBar: AppBar(
        title: const Text("BlogPost"),
        actions: isAuthorized ?[
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
            const SearchBar(
              elevation: MaterialStatePropertyAll(0),
              hintText: "Type post name",
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  side: BorderSide(color: Colors.black))),
              leading: Icon(Icons.search),
            ),
            const SizedBox(
              height: 10,
            ),
            BWTabBar(
                tabController: tabController,
                options:
                    isAuthorized ? ["My posts", "All posts"] : ["All posts"]),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        postsBloc.add(PostsFetchEvent());
                      },
                      child: SingleChildScrollView(
                        child: BlocBuilder<PostsBloc, PostsState>(
                          bloc: postsBloc,
                          builder: (context, state){
                            if(state is PostsLoading){
                              return const Center(
                                child: CircularProgressIndicator()
                              );
                            } else if(state is PostsLoaded){
                              return PostsList(posts: state.posts);
                            } else {
                              return const Placeholder();
                            }
                          }
                        ),
                      )
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        postsBloc.add(PostsFetchEvent());
                      },
                      child: SingleChildScrollView(
                        child: BlocBuilder<PostsBloc, PostsState>(
                          bloc: postsBloc,
                          builder: (context, state){
                            if(state is PostsLoading){
                              return const Center(
                                child: CircularProgressIndicator()
                              );
                            } else if(state is PostsLoaded){
                              return PostsList(posts: state.posts);
                            } else {
                              return const Placeholder();
                            }
                          }
                        ),
                      )
                    ),
                  ]
              ),
            )
            /*
            RefreshIndicator(
              onRefresh: () async {},
              child: BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  if(state is PostsLoading){
                    return  const Expanded(
                      child: Center(
                        child: CircularProgressIndicator()
                      )
                    );
                  } else if(state is PostsLoaded){
                    return Expanded(
                    child: TabBarView(
                        controller: tabController,
                        children: isAuthorized ? [
                          PostsList(posts: state.posts),
                          PostsList(posts: state.posts)
                        ] : [
                          PostsList(posts: state.posts)
                        ]),
                  );
                  } else if(state is PostsError){
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline_sharp,
                              color: Colors.red,
                              size: 50,
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              state.message,
                              style: const TextStyle(
                                fontSize: 20
                              ),
                            ),
                          ],
                        )
                      )
                    );
                  } else {
                    return Placeholder();
                  }
                },
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}

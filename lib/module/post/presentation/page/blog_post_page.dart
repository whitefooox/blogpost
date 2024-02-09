import 'package:blogpost/core/widget/bw_icon_button.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/post/presentation/state/bloc/posts_bloc.dart';
import 'package:blogpost/module/post/presentation/widget/bw_tab_bar.dart';
import 'package:blogpost/module/post/presentation/widget/post_tile.dart';
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
    final isAuthorized =
        authBloc.state.authGlobalStatus == AuthGlobalStatus.authorized;

    final tabController =
        TabController(length: isAuthorized ? 2 : 1, vsync: this);

    return Scaffold(
      floatingActionButton: isAuthorized
          ? BwIconButton(
              isEnabled: false,
              iconData: Icons.add,
              onPressed: () {},
            )
          : null,
      appBar: AppBar(
        title: const Text("BlogPost"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            const SearchBar(
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
            BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                if(state is PostsLoading){
                  return  CircularProgressIndicator();
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
                } else {
                  return Placeholder();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

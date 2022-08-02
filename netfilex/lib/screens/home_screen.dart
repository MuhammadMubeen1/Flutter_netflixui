import 'package:flutter/material.dart';
import 'package:netfilex/data/data.dart';
import '../widgets/content_List.dart';
import '../widgets/content_header.dart';
import '../widgets/custum_appbar.dart';
import '../widgets/previews.dart';
class HomeScreen extends StatefulWidget {  
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        _scrollOffset = _scrollController.offset;
      });
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: Icon(Icons.cast),
          // ignore: avoid_print
          onPressed: () {
            print('Cast');
          }),
      appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 50.0),
          child: CustomAppBar(
            scrollOffset: _scrollOffset,
          )),
      body: CustomScrollView(
        controller: _scrollController,
        // ignore: prefer_const_literals_to_create_immutables
        slivers: [
          const SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
           const SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('myList'),
              title: 'My List',
              contentList: myList,
            ),
          ),
          const SliverToBoxAdapter(
            child: ContentList(
              
              key: PageStorageKey('originals'),
              title: 'Netflix Originals',
              contentList: originals,
              isOriginals: true,
            ),
          ),
          
          const SliverPadding( 
            padding: EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey('trending'),
                title: 'Trending',
                contentList: trending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

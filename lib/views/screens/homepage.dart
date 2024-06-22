import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool popular = true;
  bool fashion = false;

  @override
  void initState() {
    super.initState();
    popular = true;
    fashion = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: _buildAppBarIcon(Icons.arrow_back_ios_new_rounded),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: _buildAppBarIcon(CupertinoIcons.ellipsis_vertical),
              ),
            ],
            pinned: true,
            title: const Text(
              "Order Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    _buildContainer(Color(0xffDED9D5), 70, true),
                    Expanded(
                      child: _buildImageContainer(
                        "https://c8.alamy.com/comp/MFGNBF/stylish-african-american-boy-on-gray-sweater-and-glasses-posed-at-street-fashionable-black-guy-MFGNBF.jpg",
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(30)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildHeader("Popular", popular),
          _buildGridContent(10),
          _buildHeader("Men's Fashion", fashion),
          _buildListContent(10),
        ],
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(child: Icon(icon)),
      ),
    );
  }

  Widget _buildContainer(Color color, double height, bool isTop) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        borderRadius: isTop
            ? const BorderRadius.vertical(top: Radius.circular(30))
            : const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      height: height,
    );
  }

  Widget _buildImageContainer(
    String url, {
    BorderRadius? borderRadius,
    double? height,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: borderRadius),
      child:
          Image.network(url, fit: BoxFit.cover, alignment: Alignment.topCenter),
    );
  }

  Widget _buildHeader(String title, bool pinned) {
    return SliverPersistentHeader(
      pinned: pinned,
      delegate: _HeaderDelegate(
        minHeight: 65,
        maxHeight: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const Text("See all", style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridContent(int itemCount) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 7) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                popular = true;
                fashion = false;
              });
            });
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageContainer(
                  height: 200,
                  "https://c8.alamy.com/comp/MFGNBF/stylish-african-american-boy-on-gray-sweater-and-glasses-posed-at-street-fashionable-black-guy-MFGNBF.jpg",
                  borderRadius: BorderRadius.circular(20),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$ 45.50"),
                      Icon(Icons.favorite_border),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Stefano Ricci",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: itemCount,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: .7,
      ),
    );
  }

  Widget _buildListContent(int itemCount) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 7) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                popular = false;
                fashion = true;
              });
            });
          }
          return Container(
            height: 120,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.grey, Colors.grey, Colors.black],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  child: _buildImageContainer(
                    height: 200,
                    "https://wallpapers.com/images/hd/stylish-manin-denim-outfit-wov6tejm4eafgg7p.png",
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: itemCount,
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent;
  }
}

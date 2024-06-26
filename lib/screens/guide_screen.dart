import 'package:flutter/material.dart';
import 'package:madnew/models/guide_model.dart';
import 'package:madnew/screens/guide_detail.dart';
import 'package:madnew/screens/video_detail.dart';

class NewsHomePage extends StatelessWidget {
  const NewsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Guide",
                  style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                // Search bar
                _buildSearchBar(),
                const SizedBox(
                  height: 20,
                ),
                // Guide images
                _buildGuideImages(context),
                const SizedBox(
                  height: 10,
                ),
                // Articles section
                _buildArticlesSection(context),
                const SizedBox(
                  height: 20,
                ),
                // Videos section
                _buildVideosSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color.fromARGB(31, 151, 146, 146),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: Colors.black45,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuideImages(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: Image.asset(
                "assets/images/1.png",
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.95,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticlesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Articles",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "See more",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                final news = newsItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailNews(news: news),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 130,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(news.image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 150,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                news.newsTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: news.color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: news.color.withOpacity(0.4),
                                width: 1.5,
                              ),
                            ),
                            margin: EdgeInsets.only(left: 10, top: 5),
                            padding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            child: Text(
                              news.newsCategories,
                              style: TextStyle(
                                color: news.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Videos",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "See more",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videoItems.length,
              itemBuilder: (context, index) {
                final video = videoItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailVideo(video: video),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 100,
                                width: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(video.image),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Center(
                                child: Icon(
                                  Icons.play_circle_fill,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 150,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                video.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: video.color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: video.color.withOpacity(0.4),
                                width: 1.5,
                              ),
                            ),
                            margin: EdgeInsets.only(left: 10, top: 5),
                            padding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            child: Text(
                              video.category,
                              style: TextStyle(
                                color: video.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GuideScreen extends StatelessWidget {
  const GuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide'),
      ),
      body: Center(
        child: Text(
          'This is the guide screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

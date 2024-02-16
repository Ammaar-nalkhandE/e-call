import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';



class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _articles = []; // List to store fetched articles

  @override
  void initState() {
    super.initState();
    // Fetch news data when the screen loads
    _fetchNews();
  }

  void _fetchNews() async {
    // List of keywords for filtering news articles
    List<String> keywords = [
      'climate change',
      'forest',
      'animal',
      'birds',
      'ecosystem',
      'global warming',
      'biodiversity',
      'eco-friendly',
      'pollution',
      'nature',
      'extinct',
      'wildlife',
    ];

    // Create a query string with the keywords
    String query = keywords.join(' OR ');

    // API endpoint URL for environment-related news with keyword filtering
    final String apiKey = 'fca8bca94f9d45edac2853361f92209d'; // Replace with your NewsAPI key
    final String apiUrl = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

    // Make API request to fetch news data
    var response = await http.get(Uri.parse(apiUrl));

    // Check if the request was successful and response contains data
    if (response.statusCode == 200) {
      // Decode JSON response
      var jsonData = jsonDecode(response.body);

      // Extract articles from response
      List<dynamic> articles = jsonData['articles'];

      // Filter articles to only include those containing keywords in the title (case-insensitive)
      articles = articles.where((article) {
        String title = article['title'].toString().toLowerCase();
        return keywords.any((keyword) => title.contains(keyword));
      }).toList();

      // Update state with fetched articles
      setState(() {
        _articles = articles;
      });
    } else {
      // Request failed, handle error
      print('Failed to fetch news: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Environment News'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: _articles.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _articles.length,
          itemBuilder: (context, index) {
            final article = _articles[index];
            return Card(
              child: ListTile(
                title: Text(article['title']),
                subtitle: Text(article['description']),
                onTap: () {
                  // Handle article tap
                  _openArticleUrl(article['url']);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to open the news article URL
  void _openArticleUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
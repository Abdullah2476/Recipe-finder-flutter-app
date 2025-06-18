import 'package:flutter/material.dart';
import 'package:recipefinder/core/UI/Screens/home/detailrecipe.dart';
import 'package:recipefinder/core/services/API/recipeAPI.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  Future? recipesFuture;
  void fetchRecipes() {
    setState(() {
      // recipesFuture = searchRecipe();
      recipesFuture = searchRecipe(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Recipe by ingredients",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[400],
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,

              decoration: InputDecoration(
                hintText: "Enter Ingredients",
                filled: true,
                fillColor: Colors.orange[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.deepOrange[400]),
                hintStyle: TextStyle(color: Colors.orange[300]),
              ),
              style: TextStyle(color: Colors.brown[800]),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              fetchRecipes();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange[400],
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 3,
            ),
            child: Text(
              "Get Recipe",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: double.infinity,

                child: FutureBuilder(
                  future: recipesFuture,
                  builder: (context, snp) {
                    if (snp.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snp.hasError) {
                      return Center(child: Text("Error: ${snp.error}"));
                    } else if (!snp.hasData || snp.data == null) {
                      return Center(
                        child: Text(
                          "No recipes found",
                          style: TextStyle(
                            color: Colors.brown[600],
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    } else {
                      final data = snp.data as List;

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                final itemId = data[index]['id'];
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailPage(
                                      recipeId: itemId as int,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            data[index]['image'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 170,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            // ignore: deprecated_member_use
                                            Colors.black.withOpacity(0.7),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        data[index]['title'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
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
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

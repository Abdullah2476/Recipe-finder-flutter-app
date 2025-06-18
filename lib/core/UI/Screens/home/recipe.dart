import 'package:flutter/material.dart';
import 'package:recipefinder/core/UI/Screens/home/detailrecipe.dart'
    show RecipeDetailPage;
import 'package:recipefinder/core/services/API/recipeAPI.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Food Recipes",
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
      body: FutureBuilder(
        future: getrecipe(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No data available"));
          }
          if (snapshot.data is String) {
            return Center(
              child: Text("Error loading recipes: ${snapshot.data}"),
            );
          }
          final recipes = snapshot.data as List;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final item = recipes[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    final itemId = item['id'];
                    int recipeId;
                    if (itemId is int) {
                      recipeId = itemId;
                    } else if (itemId is String) {
                      recipeId = int.tryParse(itemId) ?? 0;
                    } else {
                      recipeId = 0;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RecipeDetailPage(recipeId: recipeId);
                        },
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
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(item['image'] as String),
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
                            item['title'] as String,
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
        },
      ),
    );
  }
}

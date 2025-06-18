import 'package:flutter/material.dart';
import 'package:recipefinder/core/services/API/recipeAPI.dart';

class RecipeDetailPage extends StatelessWidget {
  final int recipeId;

  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            return Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          "Recipe Detail",
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
        future: getdetailRecipe(recipeId), // Changed to match your API function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No recipe details available"));
          }

          final recipe = snapshot.data as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(
                            recipe['image'] as String, //erro causing
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      // top: 150,
                      left: 10,
                      right: 10,
                      child: Container(
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(25),
                          ),
                          color: Colors.deepOrange[50],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text(
                                  recipe['title'] as String? ?? 'No title',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          color: Colors.deepOrange[400],
                                        ),
                                        Text(
                                          " ${recipe['readyInMinutes'].toString()} min",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.health_and_safety,
                                          color: Colors.deepOrange[400],
                                        ),
                                        Text(
                                          " ${recipe['healthScore'].toString()}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.donut_large_rounded,
                                          color: Colors.deepOrange[400],
                                        ),
                                        Text(
                                          " ${recipe['servings'].toString()} serve",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ingredients:',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w600,

                      color: Colors.grey[800],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        (recipe['extendedIngredients'] as List?)?.length ?? 0,
                    itemBuilder: (context, index) {
                      final ingredient =
                          (recipe['extendedIngredients'] as List)[index]
                              as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.orange[50]!,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.orange[100]!,
                                    width: 1.5,
                                  ),
                                ),
                                child: Image.network(
                                  'https://spoonacular.com/cdn/ingredients_100x100/${ingredient['image'] as String}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ingredient['name'] as String,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.brown[800],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${ingredient['amount'] is double ? (ingredient['amount'] as double).toString() : ingredient['amount'].toString()} ${ingredient['unit'] as String}',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.deepOrange[800],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),

                Text(
                  'Cooking Instructions:',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey[800],
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  width: 600,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,

                    itemBuilder: (context, index) {
                      final steps =
                          recipe['analyzedInstructions'][0]['steps'] as List;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: 650,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFFFF3E0),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Step ${steps[index]['number']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFFFF6D00),
                                ),
                              ),
                              Text(
                                steps[index]['step'],
                                style: TextStyle(color: Color(0xFF5D4037)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },

                    itemCount:
                        (recipe['analyzedInstructions'][0]['steps'] as List)
                            .length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

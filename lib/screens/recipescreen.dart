import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumly/models/meal_models.dart';

class RecipeScreen extends StatelessWidget {
  final MealModel meal;

  const RecipeScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset(
          'images/logo.png', 
          height: 30,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          
            // Recipe Image
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(meal.image ?? 
                      'https://p.kindpng.com/picc/s/79-798754_hoteles-y-centros-vacacionales-dish-placeholder-hd-png.png'), // Placeholder
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Recipe Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Name
                  Text(
                    meal.name ?? 'Recipe Name',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Ingredients Section
                  Text(
                    "Ingredients",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: meal.ingredients.map((ingredient) {
                      return Row(
                        children: [
                          Text(
                            ingredient.name ?? 'No name',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            ingredient.measure ?? 'No ingredients',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),

                  // Instructions Section
                  Text(
                    "Instructions",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    meal.instructions ?? 'No instructions available.',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

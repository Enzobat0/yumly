import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumly/models/meal_models.dart';
import 'package:yumly/provider/meal_providers.dart';
import 'package:yumly/screens/recipescreen.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> categories = ["All", "Breakfast", "Dessert", "Vegetarian"];
  String selectedCategory = "All";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final meals = searchQuery.isNotEmpty
        ? ref.watch(searchMealsProvider(searchQuery))
        : ref.watch(mealsByCategoryProvider(selectedCategory == "All" ? "" : selectedCategory));

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Get cooking!",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onSubmitted: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search for recipes...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedCategory = category;
                      searchQuery = ""; 
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.redAccent : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.redAccent),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: meals.when(
                data: (recipes) {
                  if (recipes.isEmpty) {
                    return const Center(
                      child: Text("No recipes found."),
                    );
                  }
                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final MealModel recipe = recipes[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Image.network(
                            recipe.image,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            recipe.name,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeScreen(meal: recipe),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Text("Error: ${error.toString()}"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

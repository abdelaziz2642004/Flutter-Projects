// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'package:meals/model/category.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meals/model/category.dart';
// import 'package:meals/model/meal.dart';

// enum Filters { gluten, lactose, vegetarian, vegan }

// // Constants in Dart should be written in lowerCamelcase.
// final List<Category> availableCategories = [
//   Category(
//       id: 'c1',
//       title: 'Italian',
//       url:
//           'https://media.istockphoto.com/id/1357098864/photo/italian-spaghetti-on-rustic-wooden-table.jpg?s=612x612&w=0&k=20&c=SyH_8JlGcf48JKdbWtiLHjlw337H31rwgY18Hysmj1U='),
//   Category(
//       id: 'c2',
//       title: 'Quick & Easy',
//       url:
//           'https://www.budgetbytes.com/wp-content/uploads/2016/04/Cheeseburger-Pasta-close-800x600.jpg'),
//   Category(
//       id: 'c3',
//       title: 'Hamburgers',
//       url:
//           'https://media.istockphoto.com/id/1482650278/photo/juicy-ground-pork-and-bacon-cheeseburger-with-fries.jpg?s=2048x2048&w=is&k=20&c=y6MZUSsyMe29RzE4J3MT9H4JtZd4PwYf7x0BEnyVTqc='),
//   Category(
//       id: 'c4',
//       title: 'German',
//       url:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVgX7WGofhv0piqEXCIi4RyvmwQ-PlRNRBPw&s'),
//   Category(
//       id: 'c5',
//       title: 'Light & Lovely',
//       url:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgw8vi1UXeU5fuPj7JoDZXxhBDb-SKFnWX3g&s'),
//   Category(
//       id: 'c6',
//       title: 'Exotic',
//       url:
//           'https://plus.unsplash.com/premium_photo-1683120880375-074c4ba3f775?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2hvY29sYXRlfGVufDB8fDB8fHww'),
//   Category(
//       id: 'c7',
//       title: 'Breakfast',
//       url:
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/%C5%9Aniadanie.jpg/330px-%C5%9Aniadanie.jpg'),
//   Category(
//       id: 'c8',
//       title: 'Asian',
//       url:
//           'https://images.prismic.io/orientalmart/Znw3lZbWFbowe4bJ_Untitleddesign-5-.jpg?auto=format,compress'),
//   Category(
//       id: 'c9',
//       title: 'French',
//       url:
//           'https://admin.expatica.com/fr/wp-content/uploads/sites/5/2023/11/ratatouille.jpg'),
//   Category(
//       id: 'c10',
//       title: 'Summer',
//       url:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrctyHaAu3DC-XrIbWonti0XJnpsO0rB07LQ&s'),
// ];

// // I ran this with a button in the main to create the meals in the firebase
// Future<void> uploadCategoriesToFirestore() async {
//   final firestore = FirebaseFirestore.instance;

//   // Iterate over availableCategories and add each to Firestore
//   for (var category in availableCategories) {
//     // Convert Color to hexadecimal string

//     // Use category ID as the document ID in Firestore
//     await firestore.collection('Categories').doc(category.id).set({
//       'title': category.title,
//       'url': category.url,
//     });
//   }
// }

// Future<void> uploadMealsToEachCategoryFirestore() async {
//   final firestore = FirebaseFirestore.instance;

//   for (var meal in dummyMeals) {
//     await firestore
//         .collection('Meals')
//         .doc(meal.id) // Use the meal ID as the document ID
//         .set({
//       'categories': meal.categories,
//       'duration': meal.duration,
//       'title': meal.title,
//       'imageUrl': meal.imageUrl,
//       'ingredients': meal.ingredients,
//       'steps': meal.steps,
//       'isGlutenFree': meal.isGlutenFree,
//       'isVegan': meal.isVegan,
//       'isVegetarian': meal.isVegetarian,
//       'isLactoseFree': meal.isLactoseFree,
//       'affordability': meal.affordability.name,
//       'complexity': meal.complexity.name,
//     });
//   }
// }

// List<Meal> dummyMeals = [
//   Meal(
//     id: 'm1',
//     categories: [
//       'c1',
//       'c2',
//     ],
//     title: 'Spaghetti with Tomato Sauce',
//     affordability: Affordability.affordable,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
//     duration: 20,
//     ingredients: [
//       '4 Tomatoes',
//       '1 Tablespoon of Olive Oil',
//       '1 Onion',
//       '250g Spaghetti',
//       'Spices',
//       'Cheese (optional)'
//     ],
//     steps: [
//       'Cut the tomatoes and the onion into small pieces.',
//       'Boil some water - add salt to it once it boils.',
//       'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.',
//       'In the meantime, heaten up some olive oil and add the cut onion.',
//       'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.',
//       'The sauce will be done once the spaghetti are.',
//       'Feel free to add some cheese on top of the finished dish.'
//     ],
//     isGlutenFree: false,
//     isVegan: true,
//     isVegetarian: true,
//     isLactoseFree: true,
//   ),
//   Meal(
//     id: 'm2',
//     categories: [
//       'c2',
//     ],
//     title: 'Toast Hawaii',
//     affordability: Affordability.affordable,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
//     duration: 10,
//     ingredients: [
//       '1 Slice White Bread',
//       '1 Slice Ham',
//       '1 Slice Pineapple',
//       '1-2 Slices of Cheese',
//       'Butter'
//     ],
//     steps: [
//       'Butter one side of the white bread',
//       'Layer ham, the pineapple and cheese on the white bread',
//       'Bake the toast for round about 10 minutes in the oven at 200°C'
//     ],
//     isGlutenFree: false,
//     isVegan: false,
//     isVegetarian: false,
//     isLactoseFree: false,
//   ),
//   Meal(
//     id: 'm3',
//     categories: [
//       'c2',
//       'c3',
//     ],
//     title: 'Classic Hamburger',
//     affordability: Affordability.pricey,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
//     duration: 45,
//     ingredients: [
//       '300g Cattle Hack',
//       '1 Tomato',
//       '1 Cucumber',
//       '1 Onion',
//       'Ketchup',
//       '2 Burger Buns'
//     ],
//     steps: [
//       'Form 2 patties',
//       'Fry the patties for c. 4 minutes on each side',
//       'Quickly fry the buns for c. 1 minute on each side',
//       'Bruch buns with ketchup',
//       'Serve burger with tomato, cucumber and onion'
//     ],
//     isGlutenFree: false,
//     isVegan: false,
//     isVegetarian: false,
//     isLactoseFree: true,
//   ),
//   Meal(
//     id: 'm4',
//     categories: [
//       'c4',
//     ],
//     title: 'Wiener Schnitzel',
//     affordability: Affordability.luxurious,
//     complexity: Complexity.challenging,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
//     duration: 60,
//     ingredients: [
//       '8 Veal Cutlets',
//       '4 Eggs',
//       '200g Bread Crumbs',
//       '100g Flour',
//       '300ml Butter',
//       '100g Vegetable Oil',
//       'Salt',
//       'Lemon Slices'
//     ],
//     steps: [
//       'Tenderize the veal to about 2–4mm, and salt on both sides.',
//       'On a flat plate, stir the eggs briefly with a fork.',
//       'Lightly coat the cutlets in flour then dip into the egg, and finally, coat in breadcrumbs.',
//       'Heat the butter and oil in a large pan (allow the fat to get very hot) and fry the schnitzels until golden brown on both sides.',
//       'Make sure to toss the pan regularly so that the schnitzels are surrounded by oil and the crumbing becomes ‘fluffy’.',
//       'Remove, and drain on kitchen paper. Fry the parsley in the remaining oil and drain.',
//       'Place the schnitzels on awarmed plate and serve garnishedwith parsley and slices of lemon.'
//     ],
//     isGlutenFree: false,
//     isVegan: false,
//     isVegetarian: false,
//     isLactoseFree: false,
//   ),
//   Meal(
//     id: 'm5',
//     categories: [
//       'c2'
//           'c5',
//       'c10',
//     ],
//     title: 'Salad with Smoked Salmon',
//     affordability: Affordability.luxurious,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
//     duration: 15,
//     ingredients: [
//       'Arugula',
//       'Lamb\'s Lettuce',
//       'Parsley',
//       'Fennel',
//       '200g Smoked Salmon',
//       'Mustard',
//       'Balsamic Vinegar',
//       'Olive Oil',
//       'Salt and Pepper'
//     ],
//     steps: [
//       'Wash and cut salad and herbs',
//       'Dice the salmon',
//       'Process mustard, vinegar and olive oil into a dessing',
//       'Prepare the salad',
//       'Add salmon cubes and dressing'
//     ],
//     isGlutenFree: true,
//     isVegan: false,
//     isVegetarian: true,
//     isLactoseFree: true,
//   ),
//   Meal(
//     id: 'm6',
//     categories: [
//       'c6',
//       'c10',
//     ],
//     title: 'Delicious Orange Mousse',
//     affordability: Affordability.affordable,
//     complexity: Complexity.hard,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
//     duration: 240,
//     ingredients: [
//       '4 Sheets of Gelatine',
//       '150ml Orange Juice',
//       '80g Sugar',
//       '300g Yoghurt',
//       '200g Cream',
//       'Orange Peel',
//     ],
//     steps: [
//       'Dissolve gelatine in pot',
//       'Add orange juice and sugar',
//       'Take pot off the stove',
//       'Add 2 tablespoons of yoghurt',
//       'Stir gelatin under remaining yoghurt',
//       'Cool everything down in the refrigerator',
//       'Whip the cream and lift it under die orange mass',
//       'Cool down again for at least 4 hours',
//       'Serve with orange peel',
//     ],
//     isGlutenFree: true,
//     isVegan: false,
//     isVegetarian: true,
//     isLactoseFree: false,
//   ),
//   Meal(
//     id: 'm7',
//     categories: [
//       'c7',
//     ],
//     title: 'Pancakes',
//     affordability: Affordability.affordable,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
//     duration: 20,
//     ingredients: [
//       '1 1/2 Cups all-purpose Flour',
//       '3 1/2 Teaspoons Baking Powder',
//       '1 Teaspoon Salt',
//       '1 Tablespoon White Sugar',
//       '1 1/4 cups Milk',
//       '1 Egg',
//       '3 Tablespoons Butter, melted',
//     ],
//     steps: [
//       'In a large bowl, sift together the flour, baking powder, salt and sugar.',
//       'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.',
//       'Heat a lightly oiled griddle or frying pan over medium high heat.',
//       'Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot.'
//     ],
//     isGlutenFree: true,
//     isVegan: false,
//     isVegetarian: true,
//     isLactoseFree: false,
//   ),
//   Meal(
//     id: 'm8',
//     categories: [
//       'c8',
//     ],
//     title: 'Creamy Indian Chicken Curry',
//     affordability: Affordability.pricey,
//     complexity: Complexity.challenging,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
//     duration: 35,
//     ingredients: [
//       '4 Chicken Breasts',
//       '1 Onion',
//       '2 Cloves of Garlic',
//       '1 Piece of Ginger',
//       '4 Tablespoons Almonds',
//       '1 Teaspoon Cayenne Pepper',
//       '500ml Coconut Milk',
//     ],
//     steps: [
//       'Slice and fry the chicken breast',
//       'Process onion, garlic and ginger into paste and sauté everything',
//       'Add spices and stir fry',
//       'Add chicken breast + 250ml of water and cook everything for 10 minutes',
//       'Add coconut milk',
//       'Serve with rice'
//     ],
//     isGlutenFree: true,
//     isVegan: false,
//     isVegetarian: false,
//     isLactoseFree: true,
//   ),
//   Meal(
//     id: 'm9',
//     categories: [
//       'c9',
//     ],
//     title: 'Chocolate Souffle',
//     affordability: Affordability.affordable,
//     complexity: Complexity.hard,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
//     duration: 45,
//     ingredients: [
//       '1 Teaspoon melted Butter',
//       '2 Tablespoons white Sugar',
//       '2 Ounces 70% dark Chocolate, broken into pieces',
//       '1 Tablespoon Butter',
//       '1 Tablespoon all-purpose Flour',
//       '4 1/3 tablespoons cold Milk',
//       '1 Pinch Salt',
//       '1 Pinch Cayenne Pepper',
//       '1 Large Egg Yolk',
//       '2 Large Egg Whites',
//       '1 Pinch Cream of Tartar',
//       '1 Tablespoon white Sugar',
//     ],
//     steps: [
//       'Preheat oven to 190°C. Line a rimmed baking sheet with parchment paper.',
//       'Brush bottom and sides of 2 ramekins lightly with 1 teaspoon melted butter; cover bottom and sides right up to the rim.',
//       'Add 1 tablespoon white sugar to ramekins. Rotate ramekins until sugar coats all surfaces.',
//       'Place chocolate pieces in a metal mixing bowl.',
//       'Place bowl over a pan of about 3 cups hot water over low heat.',
//       'Melt 1 tablespoon butter in a skillet over medium heat. Sprinkle in flour. Whisk until flour is incorporated into butter and mixture thickens.',
//       'Whisk in cold milk until mixture becomes smooth and thickens. Transfer mixture to bowl with melted chocolate.',
//       'Add salt and cayenne pepper. Mix together thoroughly. Add egg yolk and mix to combine.',
//       'Leave bowl above the hot (not simmering) water to keep chocolate warm while you whip the egg whites.',
//       'Place 2 egg whites in a mixing bowl; add cream of tartar. Whisk until mixture begins to thicken and a drizzle from the whisk stays on the surface about 1 second before disappearing into the mix.',
//       'Add 1/3 of sugar and whisk in. Whisk in a bit more sugar about 15 seconds.',
//       'whisk in the rest of the sugar. Continue whisking until mixture is about as thick as shaving cream and holds soft peaks, 3 to 5 minutes.',
//       'Transfer a little less than half of egg whites to chocolate.',
//       'Mix until egg whites are thoroughly incorporated into the chocolate.',
//       'Add the rest of the egg whites; gently fold into the chocolate with a spatula, lifting from the bottom and folding over.',
//       'Stop mixing after the egg white disappears. Divide mixture between 2 prepared ramekins. Place ramekins on prepared baking sheet.',
//       'Bake in preheated oven until scuffles are puffed and have risen above the top of the rims, 12 to 15 minutes.',
//     ],
//     isGlutenFree: true,
//     isVegan: false,
//     isVegetarian: true,
//     isLactoseFree: false,
//   ),
//   Meal(
//     id: 'm10',
//     categories: [
//       'c2',
//       'c5',
//       'c10',
//     ],
//     title: 'Asparagus Salad with Cherry Tomatoes',
//     affordability: Affordability.luxurious,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
//     duration: 30,
//     ingredients: [
//       'White and Green Asparagus',
//       '30g Pine Nuts',
//       '300g Cherry Tomatoes',
//       'Salad',
//       'Salt, Pepper and Olive Oil'
//     ],
//     steps: [
//       'Wash, peel and cut the asparagus',
//       'Cook in salted water',
//       'Salt and pepper the asparagus',
//       'Roast the pine nuts',
//       'Halve the tomatoes',
//       'Mix with asparagus, salad and dressing',
//       'Serve with Baguette'
//     ],
//     isGlutenFree: true,
//     isVegan: true,
//     isVegetarian: true,
//     isLactoseFree: true,
//   ),
//   Meal(
//     id: 'm10',
//     categories: [
//       'c8',
//     ],
//     title: 'Sushi',
//     affordability: Affordability.luxurious,
//     complexity: Complexity.hard,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Sushi_platter.jpg/330px-Sushi_platter.jpg',
//     duration: 50,
//     ingredients: [
//       '200g Sushi Rice',
//       '1 Avocado',
//       '1 Cucumber',
//       '100g Fresh Salmon',
//       'Nori (Seaweed Sheets)',
//       'Soy Sauce',
//       'Wasabi',
//       'Pickled Ginger'
//     ],
//     steps: [
//       'Cook the sushi rice and let it cool.',
//       'Cut the avocado, cucumber, and salmon into thin strips.',
//       'Place a nori sheet on a bamboo mat, spread a thin layer of rice on top.',
//       'Arrange avocado, cucumber, and salmon on the rice.',
//       'Roll the sushi tightly using the bamboo mat.',
//       'Slice the roll into bite-sized pieces and serve with soy sauce, wasabi, and pickled ginger.'
//     ],
//     isGlutenFree: true,
//     isVegan: false,
//     isVegetarian: false,
//     isLactoseFree: true,
//   ),
//   Meal(
//     id: 'm11',
//     categories: [
//       'c3',
//       'c7',
//     ],
//     title: 'Tacos',
//     affordability: Affordability.pricey,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Carnitas.jpg/324px-Carnitas.jpg',
//     duration: 30,
//     ingredients: [
//       '300g Ground Beef',
//       '1 Onion',
//       '2 Tomatoes',
//       '1 Avocado',
//       '4 Taco Shells',
//       'Lettuce',
//       'Cheddar Cheese',
//       'Sour Cream',
//       'Taco Seasoning'
//     ],
//     steps: [
//       'Cook the ground beef with diced onions and taco seasoning.',
//       'Chop tomatoes, avocado, and lettuce.',
//       'Fill the taco shells with beef, lettuce, tomatoes, avocado, and cheese.',
//       'Top with sour cream and serve immediately.'
//     ],
//     isGlutenFree: false,
//     isVegan: false,
//     isVegetarian: false,
//     isLactoseFree: false,
//   ),
//   Meal(
//     id: 'm12',
//     categories: [
//       'c5',
//       'c6',
//     ],
//     title: 'Chocolate Cake',
//     affordability: Affordability.affordable,
//     complexity: Complexity.challenging,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Chocolate_fudge_cake.jpg/330px-Chocolate_fudge_cake.jpg',
//     duration: 90,
//     ingredients: [
//       '200g Dark Chocolate',
//       '200g Butter',
//       '200g Sugar',
//       '4 Eggs',
//       '150g Flour',
//       '50g Cocoa Powder',
//       '1 Teaspoon Baking Powder',
//       'Pinch of Salt',
//       '100ml Milk',
//     ],
//     steps: [
//       'Preheat the oven to 180°C.',
//       'Melt the chocolate and butter together.',
//       'Whisk eggs and sugar until fluffy, then add the melted chocolate mixture.',
//       'Sift together flour, cocoa powder, baking powder, and salt.',
//       'Gently fold the dry ingredients into the chocolate mixture.',
//       'Add milk and mix until smooth.',
//       'Pour the batter into a greased cake tin and bake for 45 minutes.',
//       'Allow the cake to cool before serving.'
//     ],
//     isGlutenFree: false,
//     isVegan: false,
//     isVegetarian: true,
//     isLactoseFree: false,
//   ),
//   Meal(
//     id: 'm13',
//     categories: [
//       'c8',
//     ],
//     title: 'Pad Thai',
//     affordability: Affordability.pricey,
//     complexity: Complexity.hard,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Phat_Thai_kung_Chang_Khien_street_stall.jpg/330px-Phat_Thai_kung_Chang_Khien_street_stall.jpg',
//     duration: 30,
//     ingredients: [
//       '200g Rice Noodles',
//       '150g Chicken Breast',
//       '2 Eggs',
//       '100g Bean Sprouts',
//       '50g Peanuts',
//       '1 Lime',
//       '2 Cloves Garlic',
//       '3 Tablespoons Fish Sauce',
//       '2 Tablespoons Tamarind Paste',
//       '1 Tablespoon Brown Sugar',
//       'Chili Flakes',
//       'Coriander'
//     ],
//     steps: [
//       'Cook the rice noodles according to package instructions.',
//       'Slice the chicken and stir-fry with minced garlic until fully cooked.',
//       'Push the chicken to the side and scramble the eggs in the same pan.',
//       'Mix together fish sauce, tamarind paste, and brown sugar.',
//       'Add the cooked noodles, bean sprouts, and sauce to the pan.',
//       'Toss everything together, sprinkle with peanuts, chili flakes, and coriander, and serve with lime wedges.'
//     ],
//     isGlutenFree: true,
//     isVegan: false,
//     isVegetarian: false,
//     isLactoseFree: true,
//   ),
//   Meal(
//     id: 'm14',
//     categories: [
//       'c9',
//       'c10',
//     ],
//     title: 'Margherita Pizza',
//     affordability: Affordability.affordable,
//     complexity: Complexity.simple,
//     imageUrl:
//         'https://upload.wikimedia.org/wikipedia/commons/c/c8/Pizza_Margherita_stu_spivack.jpg',
//     duration: 40,
//     ingredients: [
//       'Pizza Dough',
//       '200g Tomato Sauce',
//       '200g Mozzarella Cheese',
//       'Fresh Basil Leaves',
//       '2 Tablespoons Olive Oil',
//       'Salt and Pepper'
//     ],
//     steps: [
//       'Preheat the oven to 220°C.',
//       'Roll out the pizza dough on a floured surface.',
//       'Spread tomato sauce evenly over the dough.',
//       'Tear the mozzarella into pieces and scatter over the sauce.',
//       'Season with salt and pepper, and drizzle with olive oil.',
//       'Bake the pizza for 10-15 minutes until the crust is golden and the cheese is bubbling.',
//       'Garnish with fresh basil leaves before serving.'
//     ],
//     isGlutenFree: false,
//     isVegan: false,
//     isVegetarian: true,
//     isLactoseFree: false,
//   ),
// ];

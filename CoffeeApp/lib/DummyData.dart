// import 'package:prj/Models/WishlistItem.dart';
// import 'package:prj/Models/category.dart';
// import 'package:prj/Models/Coffee.dart';

// List<category> categories = [
//   // category(name: 'All Coffee', id: "all"),
//   // category(name: 'Espresso-Based', id: "espresso"),
//   // category(name: 'Milk-Based', id: "milk"),
//   // category(name: 'Chocolate', id: "chocolate"),
//   // category(name: 'Strong Coffee', id: "strong"),
//   // category(name: 'Light Coffee', id: "light"),
//   // category(name: 'Cold Coffee', id: "cold"),
//   // category(name: 'Sweet & Creamy', id: "sweet"),
//   // category(name: 'Traditional', id: "traditional"),
//   // category(name: 'Unique & Specialty', id: "unique"),
//   // category(name: 'Tea', id: "tea"),
//   // category(name: 'Fruit-Based', id: "fruit"),
//   // category(name: 'Milkshakes', id: "milkshake"),
// ];

// List<Coffee> coffees = [
// Coffee(
//   name: 'Turkish Coffee',
//   description:
//       'A strong, unfiltered coffee brewed with finely ground coffee beans, water, and sugar. '
//       'Traditionally made in a small pot called a "cezve" and served in a small cup. '
//       'The rich, intense flavor and thick texture make it a favorite for coffee purists. '
//       'Often enjoyed with a glass of water and a piece of Turkish delight.',
//   smallPrice: 4.00,
//   mediumPrice: 5.50,
//   largePrice: 7.00,
//   imageUrl:
//       'https://plus.unsplash.com/premium_photo-1732818136131-3dcfdaaa6a8e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//   categoryIDs: ["strong", "traditional"],
//   rating: 4.9,
//   isSugary: false,
//   isDairy: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Vienna Coffee',
//   description:
//       'A luxurious coffee drink made with espresso, hot water, and topped with whipped cream. '
//       'It balances the bitterness of coffee with the smooth sweetness of the cream. '
//       'Often sprinkled with cocoa powder or cinnamon for added flavor. '
//       'A delightful choice for those who enjoy creamy, rich coffee experiences.',
//   smallPrice: 5.25,
//   mediumPrice: 6.75,
//   largePrice: 8.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/b0/74/c7/b074c72681a59e9011b63233a8253a7a.jpg',
//   categoryIDs: ["espresso", "sweet", "traditional"],
//   rating: 4.8,
//   isSugary: true,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Irish Coffee',
//   description:
//       'A bold combination of hot coffee, Irish whiskey, sugar, and topped with a layer of cream. '
//       'It offers a warming, slightly boozy experience that’s perfect for cold evenings. '
//       'Traditionally served in a glass to showcase the distinct coffee-to-cream layers. '
//       'A favorite choice for those who enjoy a touch of alcohol in their coffee.',
//   smallPrice: 6.50,
//   mediumPrice: 8.00,
//   largePrice: 9.50,
//   imageUrl:
//       'https://i.pinimg.com/736x/56/08/2f/56082f7a1daf9d06a94e2785982979e6.jpg',
//   categoryIDs: ["strong", "unique"],
//   rating: 4.7,
//   isSugary: true,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Cortado',
//   description:
//       'A well-balanced espresso-based drink with a 1:1 ratio of espresso to steamed milk. '
//       'It has a rich coffee flavor without being too strong, thanks to the milk’s smoothness. '
//       'Cortado is perfect for those who find lattes too milky and espressos too intense. '
//       'Ideal for an afternoon pick-me-up with just the right amount of strength.',
//   smallPrice: 4.50,
//   mediumPrice: 5.75,
//   largePrice: 7.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/ca/36/b8/ca36b8f2eaeec31498d7dafbeddea126.jpg',
//   categoryIDs: ["espresso", "milk"],
//   rating: 4.8,
//   isSugary: false,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Ristretto',
//   description:
//       'A shorter, more concentrated espresso shot with less water than a regular espresso. '
//       'It delivers a sweeter, richer, and more intense coffee flavor. '
//       'Ristretto is loved by those who enjoy a bold, full-bodied coffee without the bitterness. '
//       'A true coffee purist’s dream with a strong, smooth finish.',
//   smallPrice: 3.50,
//   mediumPrice: 4.75,
//   largePrice: 6.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/6a/e4/82/6ae482a0690b8ca89fd3acd554a36d66.jpg',
//   categoryIDs: ["espresso", "strong"],
//   rating: 4.9,
//   isSugary: false,
//   isDairy: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Mazagran',
//   description:
//       'A refreshing cold coffee drink originally from Algeria, often mixed with lemon juice. '
//       'It has a bold coffee base with a zesty citrus kick, making it unique and invigorating. '
//       'Served over ice, Mazagran is an excellent alternative to traditional iced coffee. '
//       'Perfect for hot summer days when you need a coffee boost with a refreshing twist.',
//   smallPrice: 5.00,
//   mediumPrice: 6.50,
//   largePrice: 8.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/25/0b/c3/250bc3c02d350f0cb61f0f966abb4527.jpg',
//   categoryIDs: ["cold", "unique"],
//   rating: 4.6,
//   isSugary: false,
//   isDairy: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Espresso Tonic',
//   description:
//       'A trendy, modern coffee drink that combines espresso with tonic water over ice. '
//       'It has a fizzy, slightly bitter, yet refreshing taste with a citrusy undertone. '
//       'Espresso Tonic is a perfect choice for those who want a coffee with a bit of sparkle. '
//       'Ideal for adventurous coffee lovers looking for something new and exciting.',
//   smallPrice: 5.75,
//   mediumPrice: 7.00,
//   largePrice: 8.50,
//   imageUrl:
//       'https://i.pinimg.com/736x/8b/a6/91/8ba69169016f82fa6d9594e4a74d890d.jpg',
//   categoryIDs: ["cold", "unique"],
//   rating: 4.7,
//   isSugary: false,
//   isDairy: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Honey Almond Latte',
//   description:
//       'A delightful twist on a classic latte, featuring honey and almond milk for a smooth, nutty sweetness. '
//       'The honey adds natural sweetness, while the almond milk gives it a light, creamy texture. '
//       'Perfect for those who want a dairy-free, subtly sweet coffee drink. '
//       'A great option for those who love plant-based alternatives with rich flavors.',
//   smallPrice: 5.50,
//   mediumPrice: 7.00,
//   largePrice: 8.50,
//   imageUrl:
//       'https://i.pinimg.com/736x/a8/14/3a/a8143ac4789cd89413115c69d593f180.jpg',
//   categoryIDs: ["milk", "sweet", "unique"],
//   rating: 4.8,
//   isSugary: true,
//   isDairy: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Café de Olla',
//   description:
//       'A traditional Mexican coffee brewed with cinnamon and piloncillo (unrefined cane sugar). '
//       'It has a warm, spiced sweetness with a deep, rich coffee flavor. '
//       'Often enjoyed black to fully appreciate the natural caramel-like sweetness. '
//       'A wonderful option for those who enjoy warm, spiced coffee drinks with a cultural touch.',
//   smallPrice: 4.75,
//   mediumPrice: 6.25,
//   largePrice: 7.50,
//   imageUrl:
//       'https://i.pinimg.com/736x/67/65/ae/6765ae7875a3bf7b92a6cef90dee75a7.jpg',
//   categoryIDs: ["strong", "traditional", "sweet"],
//   rating: 4.7,
//   isSugary: true,
//   isDairy: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Butterscotch Latte',
//   description:
//       'A smooth and creamy latte infused with rich butterscotch syrup for a caramel-like sweetness. '
//       'The warm, buttery flavor complements the espresso beautifully, creating a comforting drink. '
//       'Topped with whipped cream and a drizzle of butterscotch sauce for extra indulgence. '
//       'A delicious treat for those who love sweet, dessert-like coffee drinks.',
//   smallPrice: 5.75,
//   mediumPrice: 7.25,
//   largePrice: 8.75,
//   imageUrl:
//       'https://i.pinimg.com/736x/cb/08/cb/cb08cb9c88f8cef7db6feebd966175b4.jpg',
//   categoryIDs: ["milk", "sweet", "unique"],
//   rating: 4.9,
//   isSugary: true,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// /////////////////////////////////
// Coffee(
//   name: 'Espresso',
//   description:
//       'A small but powerful shot of coffee brewed under high pressure. '
//       'It has a thick crema layer on top and a rich, intense flavor. '
//       'Espresso is the foundation for many other coffee drinks. '
//       'Perfect for those who love bold and strong flavors.',
//   smallPrice: 3.00,
//   mediumPrice: 4.50,
//   largePrice: 6.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/c1/2e/34/c12e344b0dc9b687b4e4f8dd04996877.jpg',
//   categoryIDs: ["espresso", "strong", "traditional"],
//   rating: 4.9,
//   isSugary: false,
//   isDairy: false,
//   isDecaf: false,
//   containsNuts: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Cappuccino',
//   description:
//       'A well-balanced coffee made with equal parts espresso, steamed milk, and frothy milk foam. '
//       'It has a smooth, creamy texture and a slightly sweet taste from the milk. '
//       'Cappuccino is often topped with cocoa or cinnamon for extra flavor. '
//       'Great for those who love a harmonious blend of coffee and milk.',
//   smallPrice: 4.50,
//   mediumPrice: 5.75,
//   largePrice: 7.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/d6/a7/2e/d6a72ecf7351c3145b35bf7f021597c7.jpg',
//   categoryIDs: ["espresso", "milk", "traditional"],
//   rating: 4.8,
//   isSugary: false,
//   isDairy: true,
//   isDecaf: false,
//   containsNuts: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Mocha',
//   description:
//       'A delicious blend of espresso, steamed milk, and rich chocolate syrup. '
//       'It offers the perfect combination of deep coffee notes and sweet chocolate flavors. '
//       'Often topped with whipped cream and a drizzle of chocolate for extra indulgence. '
//       'Ideal for those who enjoy both coffee and dessert-like drinks.',
//   smallPrice: 5.50,
//   mediumPrice: 6.75,
//   largePrice: 8.50,
//   imageUrl:
//       'https://i.pinimg.com/736x/22/8b/72/228b72a03cb98c19063193cf0188a6a3.jpg',
//   categoryIDs: ["espresso", "chocolate", "milk", "sweet"],
//   rating: 4.7,
//   isSugary: true,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Americano',
//   description:
//       'A simple yet flavorful coffee made by adding hot water to espresso. '
//       'This results in a smoother, less intense taste compared to straight espresso. '
//       'The strength can be adjusted by varying the water-to-espresso ratio. '
//       'A great option for those who prefer a lighter, longer coffee experience.',
//   smallPrice: 3.50,
//   mediumPrice: 4.75,
//   largePrice: 6.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/bc/0c/ff/bc0cffc8b21c24b4b571e98b9ab5da12.jpg',
//   categoryIDs: ["espresso", "light"],
//   rating: 4.6,
//   isSugary: false,
//   isDairy: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Flat White',
//   description:
//       'A smooth and velvety coffee made with espresso and steamed milk. '
//       'The milk is microfoamed, creating a creamy texture without the large bubbles of a cappuccino. '
//       'Flat White has a stronger coffee taste compared to lattes due to the higher coffee-to-milk ratio. '
//       'Perfect for those who enjoy a rich coffee flavor with a silky texture.',
//   smallPrice: 4.75,
//   mediumPrice: 6.00,
//   largePrice: 7.25,
//   imageUrl:
//       'https://i.pinimg.com/736x/e7/54/a0/e754a0d2dd9657ebc2c4b3d8c9e02968.jpg',
//   categoryIDs: ["espresso", "milk"],
//   rating: 4.8,
//   isSugary: false,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Iced Latte',
//   description:
//       'A refreshing coffee drink made with espresso, milk, and ice. '
//       'The cold version of a latte, offering a smooth and creamy texture with a chill. '
//       'Often lightly sweetened and customizable with different syrups. '
//       'Ideal for warm days or for those who prefer a lighter, cooler coffee experience.',
//   smallPrice: 4.75,
//   mediumPrice: 6.25,
//   largePrice: 7.75,
//   imageUrl:
//       'https://i.pinimg.com/736x/1b/a5/c6/1ba5c608a90f862abab56c7cda2340ff.jpg',
//   categoryIDs: ["cold", "milk"],
//   rating: 4.6,
//   isSugary: false,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Cold Brew',
//   description:
//       'A smooth, naturally sweet coffee brewed with cold water over several hours. '
//       'Cold Brew is less acidic and has a mellow, refreshing taste. '
//       'Served chilled, it’s a fantastic option for those who love coffee without bitterness. '
//       'Perfect for slow sipping on a hot day.',
//   smallPrice: 5.50,
//   mediumPrice: 7.00,
//   largePrice: 8.50,
//   imageUrl:
//       'https://i.pinimg.com/736x/3f/5c/f4/3f5cf41edda5b291873389bea8e79c03.jpg',
//   categoryIDs: ["cold", "light"],
//   rating: 4.9,
//   isSugary: false,
//   isDairy: false,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Matcha Latte',
//   description:
//       'A beautiful green tea latte made with finely ground Japanese matcha powder and steamed milk. '
//       'It offers a creamy texture with an earthy, slightly sweet taste. '
//       'Matcha contains antioxidants and a gentle caffeine boost for a smooth energy lift. '
//       'A great choice for those looking for a healthier, non-coffee alternative.',
//   smallPrice: 5.25,
//   mediumPrice: 6.75,
//   largePrice: 8.50,
//   imageUrl:
//       'https://i.pinimg.com/736x/81/27/a3/8127a32abf46930b2b9ab0ddb7de07fd.jpg',
//   categoryIDs: ["tea", "milk"],
//   rating: 4.7,
//   isSugary: false,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Dalgona Coffee',
//   description:
//       'A trendy whipped coffee made with instant coffee, sugar, and water, layered over milk. '
//       'It has a creamy, frothy top and a rich, sweet coffee flavor. '
//       'The light and airy texture makes it a unique and satisfying drink. '
//       'A visually appealing and delicious coffee experience!',
//   smallPrice: 5.25,
//   mediumPrice: 6.75,
//   largePrice: 8.50,
//   imageUrl:
//       'https://i.pinimg.com/736x/fa/24/33/fa24330423827d1e0de637c70f43aa43.jpg',
//   categoryIDs: ["milk", "cold", "sweet"],
//   rating: 4.8,
//   isSugary: true,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Affogato',
//   description:
//       'A simple yet indulgent dessert-style coffee made by pouring hot espresso over vanilla ice cream. '
//       'The contrast between the hot coffee and the cold, creamy ice cream creates a delightful texture. '
//       'Perfect for those who love a combination of rich coffee and sweet treats. '
//       'An excellent way to enjoy coffee as a dessert.',
//   smallPrice: 5.50,
//   mediumPrice: 7.00,
//   largePrice: 9.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/23/d2/78/23d27823c442ad4c74e2e8dca35a801f.jpg',
//   categoryIDs: ["espresso", "milk", "sweet"],
//   rating: 4.9,
//   isSugary: true,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Chocolate MilkShake',
//   description:
//       'A simple yet indulgent dessert-style Chocolate MilkSHake made by pouring cold espresso over vanilla ice cream. '
//       'The contrast between the hot coffee and the cold, creamy ice cream creates a delightful texture. '
//       'Perfect for those who love a combination of rich coffee and sweet treats. '
//       'An excellent way to enjoy coffee as a dessert.',
//   smallPrice: 5.50,
//   mediumPrice: 7.00,
//   largePrice: 9.00,
//   imageUrl:
//       'https://i.pinimg.com/236x/b0/95/0c/b0950c22362a3a30e353bac00bc2ad31.jpg',
//   categoryIDs: ["milk", "sweet", 'chocolate', 'milkshake'],
//   rating: 4.9,
//   isSugary: true,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// Coffee(
//   name: 'Cocktail',
//   description:
//       'A simple yet indulgent dessert-style juice made by pouring juice over something , idk  ice cream. '
//       'The contrast between the hot coffee and the cold, creamy ice cream creates a delightful texture. '
//       'Perfect for those who love a combination of rich coffee and sweet treats. '
//       'An excellent way to enjoy coffee as a dessert.',
//   smallPrice: 5.50,
//   mediumPrice: 7.00,
//   largePrice: 9.00,
//   imageUrl:
//       'https://i.pinimg.com/736x/50/38/62/5038620e4c3049fe852da6c5f4ebb4a9.jpg',
//   categoryIDs: ["fruit", "sweet"],
//   rating: 4.9,
//   isSugary: true,
//   isDairy: true,
//   containsCaffeine: true,
// ),
// ];

// user currentUser = user(
//   id: "",
//   email: "email",
//   wishlist: Wishlist(items: [], total: 0),
//   ImageUrl: "",
//   fullName: "fullName",
//   favorited: [],
//   notifications: [],
// );

// WishlistItem item = WishlistItem(
//   addedAt: DateTime.now(),
//   coffee: coffees[0],
//   quantity: 4,
//   size: 'S',
// );

// WishlistItem item2 = WishlistItem(
//   addedAt: DateTime.now(),
//   coffee: coffees[2],
//   quantity: 4,
//   size: 'L',
// );

// WishlistItem item3 = WishlistItem(
//   addedAt: DateTime.now(),
//   coffee: coffees[1],
//   quantity: 3,
//   size: 'M',
// );

// Map<String, String> categoryMap = {
//   // categories[0].id: categories[0].name,
//   // categories[1].id: categories[1].name,
//   // categories[2].id: categories[2].name,
//   // categories[3].id: categories[3].name,
//   // categories[4].id: categories[4].name,
//   // categories[5].id: categories[5].name,
//   // categories[6].id: categories[6].name,
//   // categories[7].id: categories[7].name,
//   // categories[8].id: categories[8].name,
//   // categories[9].id: categories[9].name,
//   // categories[10].id: categories[10].name,
//   // categories[11].id: categories[11].name,
// };
// void start() {
//   FirebaseFirestore fire = FirebaseFirestore.instance;

//   for (catego c in categories) {
//     DocumentReference docRef = fire.collection("Categories").doc(c.id);

//     docRef
//         .get()
//         .then((docSnapshot) {
//           if (docSnapshot.exists) {
//             // If the document exists, update it
//             docRef.update({
//               "name": c.name, "id": c.id, // Explicitly store the ID
//             });
//           } else {
//             // If the document doesn't exist, create it
//             docRef.set({
//               "id": c.id, // Explicitly store the ID
//               "name": c.name,
//             });
//           }
//         })
//         .catchError((error) {
//           print("Firestore error: $error");
//         });
//   }

//   // // print(item.coffeeId);
//   // // print(item2.coffeeId);
//   // // print(item3.coffee);
//   // // print(coffees[0].id);
//   // // print(coffees[1].id);
//   // // print(coffees[2].id);

//   // // currentUser.wishlist.add(item2);
//   // currentUser.wishlist.addItem(item);
//   // currentUser.wishlist.addItem(item2);
//   // currentUser.wishlist.addItem(item3);

//   // currentUser.favorited.add(coffees[0].id);
//   // currentUser.favorited.add(coffees[2].id);
//   // currentUser.notifications.add(
//   //   notification(message: "Your Password Has been changed successfully"),
//   // );

//   // currentUser.notifications.add(
//   //   notification(
//   //     message: "Check out this offer !! 70% off on mondays",
//   //     c: coffees[1],
//   //   ),
//   // );
//   // currentUser.notifications.add(
//   //   notification(
//   //     message: "Check out this offer !! 70% off on mondays",
//   //     c: coffees[1],
//   //   ),
//   // );
//   // currentUser.notifications.add(
//   //   notification(
//   //     message: "Check out this offer !! 70% off on mondays",
//   //     c: coffees[2],
//   //   ),
//   // );
//   // currentUser.notifications.add(
//   //   notification(
//   //     message: "Check out this offer !! 70% off on mondays",
//   //     c: coffees[0],
//   //   ),
//   // );
//   // currentUser.notifications.add(
//   //   notification(
//   //     message: "Check out this offer !! 70% off on mondays",
//   //     c: coffees[1],
//   //   ),
//   // );
// }

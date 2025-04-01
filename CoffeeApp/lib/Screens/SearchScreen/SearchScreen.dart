import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Providers/categoriesProvider.dart';
import 'package:prj/Providers/drinksProvider.dart';
import 'package:prj/Screens/DetailsScreen.dart/Details.dart';
import 'package:prj/Screens/HomeScreen/HelpingWidgets%20(UpperPart)/filterMenu.dart';
import 'package:prj/Screens/SearchScreen/HelpingWidgets/searchItem.dart';
import 'package:prj/Screens/SearchScreen/SearchLogic.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Coffee> filteredList = [];
  List<Coffee> availableList = [];
  String query = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredList = ref.read(drinksProvider).value ?? [];
    availableList = filteredList;
  }

  void _filterSearch(String q) {
    query = q;
    setState(() {
      searchQuery = query;
      filteredList = filterCoffeeList(
        query,
        availableList,
        ref.read(categoriesProvider).value ?? {},
      );
    });
  }

  void filtering(Map<filters, bool> Filters) {
    setState(() {
      availableList =
          ref.read(drinksProvider).value!.where((drink) {
            if (!Filters[filters.containsCaffeine]! && drink.containsCaffeine) {
              return false;
            }
            if (!Filters[filters.containsNuts]! && drink.containsNuts) {
              return false;
            }
            if (!Filters[filters.isDairy]! && drink.isDairy) {
              return false;
            }
            if (!Filters[filters.isDecaf]! && drink.isDecaf) {
              return false;
            }
            if (!Filters[filters.isSugary]! && drink.isSugary) {
              return false;
            }
            return true;
          }).toList();
    });
    _filterSearch(query);
  }

  void goToDetails(Coffee coffee) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeeDetailsScreen(coffee: coffee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Search Coffee',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'DopisBold',
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: 'search',
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Search Coffee',
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: _filterSearch,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilterMenu(fromOut: false, filtering: filtering),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return SearchItem(
                    coffee: filteredList[index],
                    searchQuery: searchQuery,
                    onTap: () => goToDetails(filteredList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

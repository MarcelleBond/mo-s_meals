import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";

  Function setFilters;
  Map<String, bool> currentFilters;
  
  FiltersScreen(this.currentFilters,this.setFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters["gluten"] as bool;
    _lactoseFree = widget.currentFilters["lactose"] as bool;
    _vegetarian = widget.currentFilters["vegetarian"] as bool;
    _vegan = widget.currentFilters["vegan"] as bool;
    super.initState();
  }

  Widget _buildSwicthListTile(String title, String subtitle, bool currentValue,
      Function(bool) updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
        actions: [
          IconButton(
              onPressed: () {
               var selectedFilter = {
                  "gluten": _glutenFree,
                  "lactose": _lactoseFree,
                  "vegetarian": _vegetarian,
                  "vegan": _vegan
                };
                widget.setFilters(selectedFilter);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Adjust your meal settings",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            _buildSwicthListTile(
              "Gluten-free",
              "Only include gluten-free meals",
              _glutenFree,
              (bool newvalue) => setState(() {
                _glutenFree = newvalue;
              }),
            ),
            _buildSwicthListTile(
              "Lactose-free",
              "Only include lactose-free meals",
              _lactoseFree,
              (bool newvalue) => setState(() {
                _lactoseFree = newvalue;
              }),
            ),
            _buildSwicthListTile(
              "Vegetarian",
              "Only include vegetarian meals",
              _vegetarian,
              (bool newvalue) => setState(() {
                _vegetarian = newvalue;
              }),
            ),
            _buildSwicthListTile(
              "Vegan",
              "Only include vegan meals",
              _vegan,
              (bool newvalue) => setState(() {
                _vegan = newvalue;
              }),
            ),
          ],
        )),
      ]),
    );
  }
}

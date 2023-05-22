import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required TextEditingController searchController,
    this.onChanged,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration.collapsed(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Search Restaurant",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                      hoverColor: Colors.transparent,
                    ),
                    controller: _searchController,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

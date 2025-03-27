import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPasswordBar extends ConsumerStatefulWidget {
  const SearchPasswordBar({super.key});

  @override
  SearchPasswordBarState createState() => SearchPasswordBarState();
}

class SearchPasswordBarState extends ConsumerState<SearchPasswordBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Agregamos un listener para cuando se esta escribiendo algo
    _searchController.addListener(() {
      if(_searchController.text.length > 3){
        //ref.read(searchQueryProvider.notifier).state = _searchController.text;
      }

      if(_searchController.text.isEmpty){
        //ref.read(searchQueryProvider.notifier).state = "";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 12 ),
          child: SizedBox(
    height: 50,
    child: TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Buscar",
        hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 13),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFB6C0DC),
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      ),
      style: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 13.0,
          fontFamily: 'Montserrat',
          letterSpacing: 0),
    ),
          ),
        );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }
}

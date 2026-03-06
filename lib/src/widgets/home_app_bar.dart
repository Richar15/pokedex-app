import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pokédex',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: SearchBar(
            controller: controller,
            hintText: 'Buscar Pokémon…',
            leading: const Icon(Icons.search),
            trailing: [
              if (controller.text.isNotEmpty)
                IconButton(icon: const Icon(Icons.clear), onPressed: onClear),
            ],
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

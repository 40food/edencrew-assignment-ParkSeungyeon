import 'package:edencrew_assignment_starter/features/search/provider/search_provider.dart';
import 'package:edencrew_assignment_starter/features/wish/provider/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    final wishProvider = context.watch<WishProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('종목 검색')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (query) {
                context.read<SearchProvider>().search(query);
              },
              decoration: const InputDecoration(
                hintText: '종목명 또는 종목코드',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            if (searchProvider.isLoading) const CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: searchProvider.results.length,
                itemBuilder: (context, index) {
                  final stock = searchProvider.results[index];
                  final isWish = wishProvider.symbols.contains(
                    'domestic:${stock.code}',
                  );
                  return SearchItem(
                    stock: stock,
                    isWish: isWish,
                    onTap: () {
                      if (isWish) {
                        wishProvider.remove(stock.code);
                      } else {
                        wishProvider.add(stock.code);
                      }
                    },
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

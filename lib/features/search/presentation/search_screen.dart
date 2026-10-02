import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../wish/provider/wish_provider.dart';
import '../provider/search_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();

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

            if (provider.isLoading) const CircularProgressIndicator(),

            Expanded(
              child: ListView.builder(
                itemCount: provider.results.length,
                itemBuilder: (context, index) {
                  final stock = provider.results[index];

                  return ListTile(
                    title: Text(stock.name),
                    subtitle: Text('${stock.code} · ${stock.typeName}'),
                    trailing: TextButton(
                      onPressed: () {
                        context.read<WishProvider>().add(
                          'domestic:${stock.code}',
                        );
                      },
                      child: const Text('추가'),
                    ),
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

import 'package:edencrew_assignment_starter/common/widgets/empty_state.dart';
import 'package:edencrew_assignment_starter/features/search/provider/search_provider.dart';
import 'package:edencrew_assignment_starter/features/wish/provider/wish_provider.dart';
import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_item.dart';
import 'search_text_field.dart';

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
    final AppDimens dimens = context.dimens;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: dimens.space4,
              right: dimens.space4,
              top: dimens.space2,
              bottom: dimens.space3,
            ),
            child: SearchTextField(controller: _controller),
          ),
          Expanded(
            child: switch (searchProvider.status) {
              SearchStatus.initial => const EmptyState(
                icon: Icons.search,
                title: '종목을 검색해 보세요',
                subtitle: '종목명 또는 종목코드 6자리로\n검색하실 수 있습니다.',
              ),
              SearchStatus.empty => EmptyState(
                icon: Icons.search_off,
                title: '검색 결과가 없습니다',
                subtitle: '\'${_controller.text}\'와\n일치하는 검색 결과를 찾지 못했습니다.',
              ),
              SearchStatus.error => const EmptyState(
                icon: Icons.error,
                title: '검색 중 오류가 발생했습니다',
                subtitle: '다시 시도해 주세요.',
              ),
              SearchStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              SearchStatus.success => ListView.builder(
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
            },
          ),
        ],
      ),
    );
  }
}

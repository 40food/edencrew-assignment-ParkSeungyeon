import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme.dart';
import '../../../common/widgets/label.dart';
import '../provider/wish_provider.dart';

class WishScreen extends StatelessWidget {
  const WishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final symbols = context.watch<WishProvider>().symbols;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(context.dimens.space4),
            child: const AppLabel('관심'),
          ),
          Expanded(
            child: symbols.isEmpty
                ? const Center(child: Text('관심 종목이 없습니다.'))
                : ListView.builder(
                    itemCount: symbols.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(symbols[index]));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

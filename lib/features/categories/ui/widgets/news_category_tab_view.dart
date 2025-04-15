import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/widgets/news_tile.dart';
import 'package:newsly/features/details/ui/details_screen.dart';
import 'package:newsly/features/categories/cubit/category_cubit.dart';
import 'package:newsly/features/categories/cubit/category_state.dart';

class NewsCategoryTabView extends StatefulWidget {
  final String category;
  const NewsCategoryTabView({super.key, required this.category});

  @override
  State<NewsCategoryTabView> createState() => _NewsCategoryTabViewState();
}

class _NewsCategoryTabViewState extends State<NewsCategoryTabView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CategoryCubit>().fetchIfNeeded();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<CategoryCubit>().fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final categoryCubit = context.read<CategoryCubit>();

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state.isLoading && state.articles == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isError) {
          return RefreshIndicator(
            onRefresh: () async => await categoryCubit.fetchNews(),
            child: Center(
              child: Text(
                state.errorMessage ?? 'Unknown error',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }
        if (state.articles == null) {
          return const Center(child: Text('No articles found'));
        }
        final articles = state.articles ?? [];

        return RefreshIndicator(
          onRefresh: () async {
            await categoryCubit.fetchNews();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: articles.length,
            itemBuilder: (_, i) => InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(article: articles[i]),
                ),
              ),
              child: NewsTile(article: articles[i], index: i),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

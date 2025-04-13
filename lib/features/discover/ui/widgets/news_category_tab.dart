import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsly/core/widgets/news_tile.dart';
import 'package:newsly/features/details/ui/details_screen.dart';
import 'package:newsly/features/discover/cubit/discover_cubit.dart';
import 'package:newsly/features/discover/cubit/discover_state.dart';

class NewsCategoryTab extends StatefulWidget {
  final String category;
  const NewsCategoryTab({super.key, required this.category});

  @override
  State<NewsCategoryTab> createState() => _NewsCategoryTabState();
}

class _NewsCategoryTabState extends State<NewsCategoryTab>
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
    context.read<DiscoverCubit>().fetchIfNeeded();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<DiscoverCubit>().fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<DiscoverCubit, DiscoverState>(
      builder: (context, state) {
        if (state.isLoading && state.articles == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isError) {
          return Center(child: Text(state.errorMessage ?? 'Unknown error'));
        }

        final articles = state.articles ?? [];
        return ListView.builder(
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
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

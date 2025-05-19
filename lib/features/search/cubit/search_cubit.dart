import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:newsly/core/models/article_model.dart';
import 'package:newsly/features/search/data/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchCubit({required this.searchRepo})
      : super(SearchState(status: SearchStatus.loading));

  Future<void> fetchSearchNews(String query) async {
    final searchResult = await searchRepo.searchNews(query);
    if (searchResult.isSuccess) {
      emit(state.copyWith(
        status: SearchStatus.loaded,
        articles: searchResult.data,
      ));
    } else {
      emit(state.copyWith(
        status: SearchStatus.error,
        errorMassage: searchResult.error,
      ));
    }
  }
}

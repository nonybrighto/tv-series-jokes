import 'package:matcher/matcher.dart';
import 'package:tv_series_jokes/models/load_state.dart';

const loading = TypeMatcher<Loading>();
const loadingMore = TypeMatcher<LoadingMore>();
const loaded = TypeMatcher<Loaded>();
const loadEnd = TypeMatcher<LoadEnd>();
const loadEmpty = TypeMatcher<LoadEmpty>();
const loadError = TypeMatcher<LoadError>();
const loadMoreError = TypeMatcher<LoadMoreError>();
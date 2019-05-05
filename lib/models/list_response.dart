import 'package:built_collection/built_collection.dart';

abstract class ListResponse<T>{


  int get totalPages;
  int get perPage;
  int get currentPage;
  int get nextPage;
  int get previousPage;
  BuiltList<T> get results; 

}
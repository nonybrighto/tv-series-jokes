abstract class LoadState{}

abstract class LoadComplete extends LoadState{}

abstract class ErrorLoad extends LoadState{}

class Loading extends LoadState{}

class LoadingMore extends LoadState{}

class Loaded extends LoadComplete{}

class LoadEnd extends LoadComplete{}

class LoadEmpty extends LoadComplete{

    final String message;
    LoadEmpty(this.message);
}

class LoadError extends ErrorLoad{

    final String message;
    LoadError(this.message);
}
class LoadMoreError extends ErrorLoad{

    final String message;
    LoadMoreError(this.message);
}
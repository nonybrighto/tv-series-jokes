abstract class BlocDelegate<T>{

    success(T t);
    error(String errorMessage);
}
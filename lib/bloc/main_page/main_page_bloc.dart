
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc extends Bloc<int, int>{
  MainPageBloc() : super(0);

  @override
  Stream<int> mapEventToState(int data) async * {
    yield data;
  }
}
import 'package:ecommerce_app/src/module/model/cart_data.dart';
import 'package:ecommerce_app/src/module/model/get_data.dart';
import 'package:equatable/equatable.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();
}

class DetailsInitial extends DetailsState {
  @override
  List<Object> get props => [];
}

class FetchData extends DetailsState {
  List<GetDetails> obj;

  FetchData({this.obj});

  FetchData copyWith({var obj}) {
    return FetchData(obj: obj ?? this.obj);
  }

  @override
  List<Object> get props => [obj];
}

class FetchMyCartData extends DetailsState {
  List<CartData> obj;

  FetchMyCartData({this.obj});

  FetchMyCartData copyWith({var obj}) {
    return FetchMyCartData(obj: obj ?? this.obj);
  }

  @override
  List<Object> get props => [obj];
}

class Loading extends DetailsState {
  @override
  List<Object> get props => [];
}

class ErrorReceived extends DetailsState {
  final err;
  ErrorReceived({this.err});
  ErrorReceived copyWith({var err}) {
    return ErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object> get props => [err];
}

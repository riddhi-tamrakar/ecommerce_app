import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class GetData extends DetailsEvent {
  final int page;
  final int perpage;

  const GetData({
    @required this.page,
    @required this.perpage,
  });
  @override
  List<Object> get props => [page, perpage];

  @override
  String toString() => 'data { page: $page,perpage: $perpage }';
}

class UpdateDetails extends DetailsEvent {
  final obj;

  const UpdateDetails({
    @required this.obj,
  });
  @override
  List<Object> get props => [
        obj,
      ];

  @override
  String toString() => 'data { value: $obj, }';
}

class DeleteItem extends DetailsEvent {
  final int id;

  const DeleteItem({
    @required this.id,
  });
  @override
  List<Object> get props => [
        id,
      ];

  @override
  String toString() => 'data { value: $id, }';
}

class GetWelcomePageData extends DetailsEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class GetMyCartDetails extends DetailsEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

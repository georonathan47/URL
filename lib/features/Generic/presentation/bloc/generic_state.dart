part of 'generic_bloc.dart';

abstract class GenericState extends Equatable {
  const GenericState();  

  @override
  List<Object> get props => [];
}
class GenericInitial extends GenericState {}

import 'package:bloc/bloc.dart';
import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/module/post/domain/entity/comment.dart';
import 'package:meta/meta.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsBloc() : super(CommentsState()) {
    on<CommentsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

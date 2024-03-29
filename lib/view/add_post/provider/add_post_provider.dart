import 'package:cj_flutter_riverpod_instagram_clone/model/dropped_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cj_flutter_riverpod_instagram_clone/view/add_post/provider/add_post_state.dart';

// ignore: depend_on_referenced_packages
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_post_provider.g.dart';

@Riverpod(keepAlive: true)
class AddPost extends _$AddPost {
  @override
  AddPostState build() {
    return const AddPostState();
  }

  void pickMediaFileList(List<XFile> mediaFileList) {
    state = state.copyWith(mediaFileList: mediaFileList);
  }

  void pickDroppedImages(List<DroppedFile> droppedImages) {
    state = state.copyWith(droppedImages: droppedImages);
  }

  void pickPreviewImage(XFile previewImage, int index) {
    state =
        state.copyWith(previewImage: previewImage, previewImageIndex: index);
  }

  void pickErrorMessage(String errorMessage) {
    state = state.copyWith(errorMessage: errorMessage);
  }
}

@Riverpod(dependencies: [])
int previewMediaIndex(PreviewMediaIndexRef ref) {
  throw UnimplementedError();
}

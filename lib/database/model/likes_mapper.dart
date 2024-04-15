import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/database/model/likes_model.dart';

LikesModel likesMapperFromResponse({required Data data}) {
  return LikesModel(
      id: data.id,
      image: data.image,
      likes: data.likes,
      text: data.text,
      tags: data.tags,
      publishDate: data.publishDate,
      owner_firstname: data.owner!.firstName,
      owner_id: data.owner!.id,
      owner_lastname: data.owner!.lastName,
      owner_picture: data.owner!.picture,
      owner_title: data.owner!.title,
      isLiked: 0);
}

Data likeModelToResponse({required LikesModel model}) {
  return Data(
      id: model.id,
      image: model.image,
      likes: model.likes,
      publishDate: model.publishDate,
      owner: Owner(
          firstName: model.owner_firstname,
          lastName: model.owner_lastname,
          id: model.owner_id,
          picture: model.owner_picture,
          title: model.owner_title),
      tags: model.tags,
      text: model.text);
}

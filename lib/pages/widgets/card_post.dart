import 'package:flutter/material.dart';
import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/database/model/likes_mapper.dart';
import 'package:pat_example_project/database/model/likes_model.dart';
import 'package:pat_example_project/pages/tags/tags_screen.dart';
import 'package:pat_example_project/utils/date.formatter.dart';
import 'package:pat_example_project/utils/string_ext.dart';

class CardPost extends StatefulWidget {
  CardPost({super.key, required this.data, required this.insertLikes, this.tagList});

  final LikesModel data;
  final Function(Data data) insertLikes;
  final Function(String tag)? tagList;
  @override
  State<CardPost> createState() => _CardPostState();
}

class _CardPostState extends State<CardPost> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.data.owner_picture ?? ''),
                    radius: 20,
                  ),
                  SizedBox(width: 8),
                  // Username
                  Text(
                    '${widget.data.owner_firstname} ${widget.data.owner_lastname}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Image.network(
              widget.data.image ?? '',
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                for (var tags in widget.data.tags!)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () => {
                        if (widget.tagList != null) {widget.tagList!(tags)} else {null}
                      },
                      child: Chip(
                        label: Container(
                          height: 20,
                          child: Text(
                            tags.toTitleCase(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: widget.data.isLiked != 0 ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                      color: widget.data.isLiked != 0 ? Colors.red : null,
                      onPressed: () {
                        if (widget.data.isLiked == 0) {
                          setState(() {
                            widget.data.likes = widget.data.likes! + 1;
                            widget.data.isLiked = 1;
                          });
                        } else {
                          setState(() {
                            widget.data.likes = widget.data.likes! - 1;
                            widget.data.isLiked = 0;
                          });
                        }
                        widget.insertLikes(likeModelToResponse(model: widget.data));
                      },
                    ),
                    Text('${widget.data.likes} likes')
                  ],
                ),
              ],
            ),
            // Caption
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.data.text ?? '-',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                children: [
                  Text(
                    'Date posted: ',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${DateFormatter.formatterDate(widget.data.publishDate!)}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoNameBuilder extends StatelessWidget {
  const VideoNameBuilder({
    super.key,
    required this.course,
    required this.index,
  });

  final CourseModel course;
  final int index;

  @override
  Widget build(BuildContext context) {
    final String title = course.videoNames![index];
    final String duration =
        (course.videoDurations != null && index < course.videoDurations!.length)
            ? course.videoDurations![index]
            : '';
    final String? whatYouLearn = course.whatYouLearn![index];
    final String videoId =
        YoutubePlayer.convertUrlToId(course.videoLinks![index]) ?? '';
    return GestureDetector(
      onTap: () {
        pushTo(context, Routes.videoPlayer, extra: {
          'videoID': videoId,
          'title': title,
          'whatYouLearn': whatYouLearn,
          'course': course,
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.play_circle_outline, color: Colors.black54),
              ],
            ),
            Gap(8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                YoutubePlayer.getThumbnail(videoId: videoId),
                width: 250,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            Gap(12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 3,
                    style: TextStyles.getSmall(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
                Gap(3),
                SizedBox(
                  width: 50,
                  child: Text(
                    '$duration min',
                    maxLines: 1,
                    style:
                        TextStyles.getSmall(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

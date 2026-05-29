import 'dart:io';

import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseMaterialWidget extends StatefulWidget {
  final IncidentFile file;
  final UploadIncidentFileBloc bloc;
  final Function() onDelete;
  final Function? fileUploaded;

  const CourseMaterialWidget({
    Key? key,
    required this.file,
    required this.bloc,
    required this.onDelete,
    this.fileUploaded,
  }) : super(key: key);

  @override
  State<CourseMaterialWidget> createState() => _CourseMaterialWidgetState();
}

class _CourseMaterialWidgetState extends State<CourseMaterialWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // if (widget.file.isLocal) {
        //   OpenFile.open(widget.file.path);
        // } else {
        //   String finalUrl = '$kBaseUrl${widget.file.link!}';
        //   Uri uri = Uri.parse(finalUrl);
        //   if (await canLaunchUrl(uri)) {
        //     launchUrl(
        //       uri,
        //       mode: LaunchMode.externalNonBrowserApplication,
        //     );
        //   }
        //}
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: const Color(0xFFE2F6F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned.fill(
                child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                BlocConsumer<UploadIncidentFileBloc, BaseState>(
                    bloc: widget.bloc,
                    listener: (context, state) {
                      if(state.isSuccess){
                      IncidentFile file = state.item!;
                      widget.file.url = file.url;
                      if (widget.fileUploaded != null) {
                      widget.fileUploaded!();
                      }}



                    },
                    builder: (context, state) {
                      


                      return Assets.icons.iconFile.image(
                          width: 25,
                          color: AppColors.primaryColor
                      );
                      return const SizedBox.shrink();
                    }),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    widget.file.originalName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
            PositionedDirectional(
              top: 0,
              end: 0,
              child: InkWell(
                  onTap: () {
                    widget.onDelete();
                  },
                  child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Icon(
                        CupertinoIcons.xmark,
                        color: Colors.white,
                        size: 12,
                      ))),
            )
          ],
        ),
      ),
    );
  }



  @override
  bool get wantKeepAlive => true;
}

import 'dart:io';

import 'package:inspector/app.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/screen_utils.dart';
import 'package:inspector/presentation/core/widget/secondary_button.widget.dart';
import 'package:inspector/presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_bloc.dart';
import 'package:inspector/presentation/incident/widget/material_widget.dart';
import 'package:inspector/presentation/incident/widget/upload_file_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class CustomUploadFilesWidget extends StatefulWidget {
  final Color boxColor;
  final Color borderColor;
  final List<IncidentFile> files;
  final List<UploadIncidentFileBloc> filesCubits;
  final int maxFilesCount;
  final Function? onChange;
  final Function? onFileUploaded;
  final Function? isAllowAddFile;
  final bool enabled;

  const CustomUploadFilesWidget({
    Key? key,
    required this.boxColor,
    required this.borderColor,
    required this.files,
    required this.filesCubits,
    required this.maxFilesCount,
    this.onChange,
    this.onFileUploaded,
    this.isAllowAddFile,
    this.enabled=true,
  }) : super(key: key);

  @override
  State<CustomUploadFilesWidget> createState() => _CustomUploadFilesWidgetState();
}

class _CustomUploadFilesWidgetState extends State<CustomUploadFilesWidget> with ScreenUtils {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        if(widget.files.isEmpty)
          SizedBox(
            height:Platform.isIOS ?40: 40,
            child: OutlinedButton(
                onPressed:widget.enabled? (){
                  pickFiles();
                }:null,

                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  // backgroundColor: const Color(0xFFE9DAE8),
                  padding: const EdgeInsets.symmetric(horizontal: 10),

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppColors.primaryColor),
                  ),
                  side:  const BorderSide(color:  AppColors.primaryColor),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(widget.enabled)
                    Assets.icons.documentFavorite.image(
                        width:25,
                        height:25,
                        color: AppColors.primaryColor
                    ),
                    if(widget.enabled)
                      const SizedBox(width: 10,),

                    Text('upload_files'.tr(),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600
                    ),),

                  ],
                )),
          ),
        if(widget.files.isEmpty)
          const SizedBox(height: 10,),
        if(widget.files.isNotEmpty)
          SizedBox(
            height: 85,
            child: ListView.builder(
                itemCount: widget.files.length+1,
                scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {

                  if(index == widget.files.length){



                    return InkWell(
                      onTap: (){


                        pickFiles();
                      },
                      child: SvgPicture.asset(
                        Assets.icons.iconAddFile.path,
                        colorFilter:const ColorFilter.mode(AppColors.primaryColor,BlendMode.srcIn,   ) ,
                        height: 60,),
                    );
                  }

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            child: CourseMaterialWidget(
                              file:  widget.files[index],
                              bloc: widget.filesCubits[index],
                              onDelete: () {

                                widget.files.removeAt(index);
                                widget.filesCubits.removeAt(index);

                                if(widget.onChange!=null){
                                  widget.onChange!();
                                }
                                setState(() {});

                              },
                              fileUploaded: (){
                                if(widget.onFileUploaded!=null) widget.onFileUploaded!();
                              },

                            ),
                          ),
                          const SizedBox(width: 20,),
                        ],
                      ),
                    ),
                  );
                }),
          )
      ],
    );
  }

  pickFiles() async{



    if(widget.isAllowAddFile!=null){

      String? notAllowMessage = widget.isAllowAddFile!();

      if(notAllowMessage!=null) {
        showError(customMessage: notAllowMessage);
        return;
      }
    }


    if(widget.files.length==widget.maxFilesCount){
      showError(customMessage: 'You can upload ${widget.maxFilesCount} file ');
      return;
    }

    var requestFileType=await openSendRequestFileBottomSheet(context);

    FilePickerResult? result;

    if(requestFileType==RequestFileType.photo) {
      result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
    }else if(requestFileType==RequestFileType.video) {
      result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.video,
      );
    }else  if(requestFileType==RequestFileType.camera){

      final ImagePicker picker = ImagePicker();

      var  imageFile = await picker
          .pickImage(source: ImageSource.camera,);

      if (imageFile == null ) return;


      var tempFile = File(imageFile.path,);
      int bytes =  tempFile.lengthSync();



      var file = IncidentFile(
        size: bytes,
        isLocal: true,
        path: imageFile.path,
        fileId: '', url: '',
        originalName: imageFile.name,
        mimeType: '', uploadedAt: DateTime.now(),
        //  platformFile: PlatformFile(path: imageFile.path,name:imageFile.name, size: bytes)
      );

      widget.files.add(file);


      /// create new cubit for file
      UploadIncidentFileBloc uploadIncidentFileBloc=getIt<UploadIncidentFileBloc>();
      //start upload file
      uploadIncidentFileBloc.add(UploadFileRequested(file: File(file.path)));
      widget.filesCubits.add(uploadIncidentFileBloc);

      if(widget.onChange!=null){
        widget.onChange!();
      }
      setState(() {});

      return;

    }



    if (result == null) return;


    for(int i=0;i<result.files.length;i++){

      /// don't add file if exist
      if(isFileExist(result.files[i])) continue;


      var file = IncidentFile(
        originalName: result.files[i].name,
        size: result.files[i].size,
        isLocal: true,
        path: result.files[i].path??'', fileId: '', url: '', mimeType: '', uploadedAt: DateTime.now(),
        // platformFile: result.files[i]
      );

      widget.files.add(file);


      /// create new cubit for file
      UploadIncidentFileBloc uploadIncidentFileBloc=getIt();
      //start upload file
      uploadIncidentFileBloc.add(UploadFileRequested(file: File(file.path)));
      widget.filesCubits.add(uploadIncidentFileBloc);

      if(widget.onChange!=null){
        widget.onChange!();
      }
    }

    setState(() {});
  }

  isFileExist(PlatformFile file){

    for(int i=0;i<widget.files.length;i++){
      if(widget.files[i].originalName== file.name) return true;
    }
    return false;
  }




}

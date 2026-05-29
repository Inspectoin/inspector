import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inspector/app.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/presentation/core/theme/app_colors.dart';
import 'package:inspector/presentation/core/utils/generated_assets/assets.gen.dart';
import 'package:inspector/presentation/core/widget/primary_button.widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inspector/presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_bloc.dart';

class SendRequestFileBottomSheet extends StatefulWidget {
  final Function(RequestFileType) onFile;
  final bool openDocuments;

  const SendRequestFileBottomSheet({
    required this.onFile,
    this.openDocuments=false,
    super.key});

  @override
  State<SendRequestFileBottomSheet> createState() => _SendFileBottomSheetState();
}

class _SendFileBottomSheetState extends State<SendRequestFileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double buttonHeight=Platform.isIOS?40: 40;

    return ClipRRect(
      borderRadius:  BorderRadius.circular(16),

      child: Container(
        height: 210.0,
        color: Colors.white, //could change this to Color(0xFF737373),
        //so you don't have to change MaterialApp canvasColor
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24,),

              Text('select_format'.tr(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 24,),

              Row(
                children: [
                 item('image'.tr(), RequestFileType.photo,'assets/images/icons/icons_image.svg'),
                 const SizedBox(width: 5,),
                 item('video'.tr(), RequestFileType.video,'assets/images/icons/video-square.svg'),
                  const SizedBox(width: 5,),

                  item('camera'.tr(), RequestFileType.camera,'assets/images/icons/Icon (2).svg'),
                  const SizedBox(width: 5,),
                  if(widget.openDocuments)

                  item('document'.tr(), RequestFileType.camera,'assets/images/icons/Icon (2).svg'),


                ],
              ),





             
              const SizedBox(height: 25,),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: buttonHeight,
                child: PrimaryButton(
                  onPressed: () async {


                    context.router.popForced();
                  }, child: Text('cancel'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  item(text,type,image){
    return Expanded(child:  SizedBox(
      height:Platform.isIOS ?40: 40,
      child: OutlinedButton(
          onPressed: (){
            widget.onFile(type);
            context.router.popForced();
          },

          style: OutlinedButton.styleFrom(
            elevation: 0,
            // backgroundColor: const Color(0xFFE9DAE8),
            padding: const EdgeInsets.symmetric(horizontal: 5),

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.primaryColor),
            ),
            side:  const BorderSide(color:  AppColors.primaryColor),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(text,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600
              ),),
            ],
          )),
    ));

  }

}

enum RequestFileType{document,photo,video,camera}


openSendRequestFileBottomSheet(context) async{

  late RequestFileType requestFileType;
 await showModalBottomSheet(
      context: context,

      shape: const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.vertical(
              top: Radius
                  .circular(16))),
      builder: (context) {
        return SendRequestFileBottomSheet(onFile: (fileType){
          requestFileType =fileType;
       //   context.router.popForced();

        },);
      });
   await Future.delayed(const Duration(milliseconds: 200));
 return requestFileType;

}


pickFilesDirect(context,bool isDocument,Function(int count,bool isDocument) onDone) async{




  late RequestFileType requestFileType;

  if(isDocument){
    requestFileType=RequestFileType.document;
  }else{
    requestFileType=await openSendRequestFileBottomSheet(context);

  }

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
  }

  else if(requestFileType==RequestFileType.document) {
    result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
  }

  else  if(requestFileType==RequestFileType.camera){

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




    return;

  }



  if (result == null) return;


  onDone(result.files.length,requestFileType==RequestFileType.document);


  // for(int i=0;i<result.files.length;i++){
  //
  //
  //
  //
  //   var file = IncidentFile(
  //     originalName: result.files[i].name,
  //     size: result.files[i].size,
  //     isLocal: true,
  //     path: result.files[i].path??'', fileId: '', url: '', mimeType: '', uploadedAt: DateTime.now(),
  //     // platformFile: result.files[i]
  //   );
  //
  //
  //
  //
  //
  // }


}


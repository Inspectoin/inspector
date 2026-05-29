import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspector/injection.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:inspector/presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_bloc.dart';


class ImageUploadItemWidget extends StatefulWidget {
  final File imageFile;
  final Function(IncidentFile incidentFile) onUploadComplete;
  final VoidCallback onRemove;

  const ImageUploadItemWidget({
    Key? key,
    required this.imageFile,
    required this.onUploadComplete,
    required this.onRemove,
  }) : super(key: key);

  @override
  _ImageUploadItemWidgetState createState() => _ImageUploadItemWidgetState();
}

class _ImageUploadItemWidgetState extends State<ImageUploadItemWidget> {
  late UploadIncidentFileBloc _uploadBloc;

  @override
  void initState() {
    super.initState();
    _uploadBloc = getIt<UploadIncidentFileBloc>() // Assuming getIt provides a new instance or a non-singleton
      ..add(UploadFileRequested(file: widget.imageFile));
  }

  // Optional: Dispose BLoC if it's created per instance and not a singleton
  // @override
  // void dispose() {
  //   _uploadBloc.close(); // Only if getIt provides a factory-new instance
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadIncidentFileBloc, BaseState<IncidentFile>>(
      bloc: _uploadBloc,
      listener: (context, state) {
        if (state.isSuccess && state.item != null) {
          widget.onUploadComplete(state.item!);
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.file(
                widget.imageFile ,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              if (state.isInProgress)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              else if (state.isFailure)
                Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 30),
                        const SizedBox(height: 4),
                        Text(
                          'Upload Failed',
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          iconSize: 24,
                          onPressed: () {
                            _uploadBloc.add(UploadFileRequested(file: widget.imageFile));
                          },
                        ),
                      ],
                    ),
                  ),
                )
              else if (state.isSuccess)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                ),
              Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  onTap: widget.onRemove, // Always allow remove, parent handles logic
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

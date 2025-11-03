import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/bloc/bloc/editor_bloc.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/bloc/bloc/editor_state.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class QuillEditorScreen extends StatefulWidget {
  const QuillEditorScreen({super.key});

  @override
  State<QuillEditorScreen> createState() => _QuillEditorScreenState();
}

class _QuillEditorScreenState extends State<QuillEditorScreen> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();
  final editorCubit = getIt<EditorCubit>();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    editorCubit.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditorCubit, EditorsState>(
      bloc: editorCubit,
      listener: (context, state) {
        if (state is EditorSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is EditorError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is EditorExported) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.blue,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditorCubit>();

        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Toolbar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: QuillSimpleToolbar(
                    controller: cubit.controller,
                    config: QuillSimpleToolbarConfig(
                      embedButtons: FlutterQuillEmbeds.toolbarButtons(),
                      color: PColors.white,
                      showFontSize: true,
                      showFontFamily: false,
                      showBoldButton: true,
                      showItalicButton: true,
                      showUnderLineButton: true,
                      showStrikeThrough: true,
                      showAlignmentButtons: true,
                      showListNumbers: true,
                      showListBullets: true,
                      showHeaderStyle: true,
                      multiRowsDisplay: false,
                      // onUndo: () => cubit.undo(),
                      // onRedo: () => cubit.redo(),
                    ),
                  ),
                ),
                // Editor
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: QuillEditor(
                      focusNode: _focusNode,
                      controller: cubit.controller,
                      scrollController: _editorScrollController,
                      config: const QuillEditorConfig(
                        placeholder: 'Start typing...',
                        padding: EdgeInsets.zero,
                        // onTextChanged: (text) => cubit.markAsChanged(),
                        customStyles: DefaultStyles(
                            paragraph: DefaultTextBlockStyle(
                              TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                height: 1.3,
                              ),
                              HorizontalSpacing(0, 0),
                              VerticalSpacing(0, 0),
                            //   const VerticalSpacing(0, 0),
                              VerticalSpacing(0, 0),
                              null,
                            ),
                            // h2: DefaultTextBlockStyle(
                            //   const TextStyle(
                            //     fontSize: 36,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.black,
                            //     height: 1.3,
                            //   ),
                            //   const VerticalSpacing(14, 8),
                            //   const VerticalSpacing(0, 0),
                            //   null,
                            // ),
                            // h3: DefaultTextBlockStyle(
                            //   const TextStyle(
                            //     fontSize: 28,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.black,
                            //     height: 1.3,
                            //   ),
                            //   const VerticalSpacing(12, 8),
                            //   const VerticalSpacing(0, 0),
                            //   null,
                            // ),
                            // paragraph: DefaultTextBlockStyle(
                            //   const TextStyle(
                            //     fontSize: 16,
                            //     color: Colors.black87,
                            //     height: 1.6,
                            //   ),
                            //   const VerticalSpacing(8, 8),
                            //   const VerticalSpacing(0, 0),
                            //   null,
                            // ),
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

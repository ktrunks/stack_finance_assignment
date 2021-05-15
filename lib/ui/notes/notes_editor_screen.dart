import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_finance_assignment/provider/notes_provider.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';
import 'package:stack_finance_assignment/util/enum.dart';
import 'package:stack_finance_assignment/util/style/style.dart';
import 'package:stack_finance_assignment/widgets/button_widget.dart';
import 'package:stack_finance_assignment/widgets/custom_progress_indicator.dart';
import 'package:stack_finance_assignment/widgets/error_widget.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: notesProvider.scaffoldKey,
        appBar: AppBar(title: Text(notesProvider.title)),
        body: Stack(
          children: [
            ListView(
              children: [
                Selector<NotesProvider, String>(
                    builder: (context, data, child) {
                      return data != ''
                          ? CustomErrorWidget(
                              data, notesProvider.dismissErrorWidget)
                          : Container();
                    },
                    selector: (buildContext, provider) => provider.error),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: screenSpacing,
                  child: Column(
                    children: [
                      Form(
                          key: notesProvider.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title',
                                style: textStyle16PrimaryColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                enabled: notesProvider.notesType !=
                                        NotesType.ViewNote
                                    ? true
                                    : false,
                                onFieldSubmitted: (terms) {},
                                textInputAction: TextInputAction.next,
                                controller: notesProvider.noteTitleController,
                                focusNode: notesProvider.noteTitleNode,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: progressColor)),
                                  hintText: 'title',
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                  //border: InputBorder.none,
                                ),
                                validator: (data) {
                                  if (data.isEmpty) {
                                    return 'Title is required';
                                  } else
                                    return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Description',
                                style: textStyle16PrimaryColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                enabled: notesProvider.notesType !=
                                        NotesType.ViewNote
                                    ? true
                                    : false,
                                onFieldSubmitted: (terms) {
                                  notesProvider.onClickOfSave();
                                },
                                textInputAction: TextInputAction.done,
                                focusNode: notesProvider.noteDescriptionNode,
                                controller:
                                    notesProvider.noteDescriptionController,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: progressColor)),
                                  hintText: 'Description',
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                  //border: InputBorder.none,
                                ),
                                validator: (data) {
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              /*Container(
                                height: 60.0,
                                width: 60.0,
                                child: FittedBox(
                                  child: FloatingActionButton(
                                    child: Column(
                                      children: [
                                        Icon(Icons.add),
                                        Text('Image')
                                      ],
                                    ),
                                    onPressed: () {
                                      notesProvider.onClickOfAddImage();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),*/
                              notesProvider.notesType != NotesType.ViewNote
                                  ? Row(
                                      children: <Widget>[
                                        ButtonWidget(
                                          buttonText: 'Save',
                                          fillColor: primaryColor,
                                          textColor: Colors.white,
                                          callBack: () {
                                            notesProvider.onClickOfSave();
                                          },
                                          textStyle:
                                              buttonTextStyle16WhiteColor,
                                          buttonStatus: true,
                                          borderRadius: 2,
                                        ),
                                      ],
                                    )
                                  : Container()
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
            Selector<NotesProvider, bool>(
                builder: (context, data, child) {
                  return data ? CustomProgressIndicator() : Container();
                },
                selector: (buildContext, provider) =>
                    provider.progressIndicatorStatus)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:stack_finance_assignment/model/notes.dart';
import 'package:stack_finance_assignment/provider/home_provider.dart';
import 'package:stack_finance_assignment/routes/sf_routes.dart';
import 'package:stack_finance_assignment/util/enum.dart';
import 'package:stack_finance_assignment/widgets/custom_delete_dialog.dart';
import 'package:stack_finance_assignment/widgets/custom_progress_indicator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: homeProvider.scaffoldKey,
        appBar: AppBar(title: Text("Notes")),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            homeProvider.onClickOfAddNote();
          },
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text('change password'),
                onTap: () {
                  homeProvider.onClickOfChangePassword();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text('Log out'),
                trailing: Icon(Icons.logout),
                onTap: () {
                  homeProvider.onClickOfSignOut();
                },
              ),
            ],
          ),
        ),
        body: Selector<HomeProvider, NetWorkResponseStatus>(
            builder: (context, data, child) {
              NetWorkResponseStatus responseStatus = data;
              Widget notesWidget;
              switch (data) {
                case NetWorkResponseStatus.ResponseData:
                  notesWidget =
                      notesResponseWidget(homeProvider.notes, homeProvider);
                  break;
                case NetWorkResponseStatus.ResponseError:
                  Center(child: Text('${homeProvider.error}'));
                  break;
                case NetWorkResponseStatus.ResponseEmpty:
                  notesWidget = Center(child: Text('No Notes'));
                  break;
                case NetWorkResponseStatus.NetworkError:
                  notesWidget = Center(child: Text('Internet Error'));
                  break;
                case NetWorkResponseStatus.Loading:
                  notesWidget = CustomProgressIndicator();
                  break;
              }
              return notesWidget;
            },
            selector: (buildContext, provider) => provider.responseStatus),
      ),
    );
  }

  Widget notesResponseWidget(List<Notes> notes, HomeProvider homeProvider) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notes.length,
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          key: Key(index.toString()),
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.2,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDeleteDialogBox(
                        data: notes.elementAt(index),
                        onClickCancel: null,
                        onClickOfDelete: homeProvider.onClickOfDelete,
                      );
                    });
              },
            ),
            IconSlideAction(
              caption: 'Edit',
              color: Colors.red,
              icon: Icons.edit,
              onTap: () {
                Map<String, dynamic> notesData = {};
                notesData['notes'] = notes.elementAt(index);
                notesData['type'] = NotesType.EditNote;
                Navigator.pushNamed(context, SFRoutes.addNote,
                    arguments: notesData);
              },
            ),
          ],
          child: InkWell(
            onTap: () {
              Map<String, dynamic> notesData = {};
              notesData['notes'] = notes.elementAt(index);
              notesData['type'] = NotesType.ViewNote;
              Navigator.pushNamed(context, SFRoutes.addNote,
                  arguments: notesData);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Title  : ${notes.elementAt(index).title}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(' Description  : ${notes.elementAt(index).desc ?? ''}',
                        softWrap: true, maxLines: 2),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

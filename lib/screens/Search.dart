import 'package:appia/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../appia.dart';

class Search extends StatelessWidget {
  static const routeName = 'Search';
  SearchList ts = new SearchList();

  @override
  Widget build(BuildContext context) {
    final userDataProvider = UserDataProvider(httpClient: http.Client());
    final userRepository = UserRepository(userDataProvider: userDataProvider);
    final searchBloc = UserBloc(userRepository);
    return BlocProvider(
      create: (context) => searchBloc..add(GetAllUsers()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left_outlined),
            onPressed: () {},
          ),
          title: TextField(
            decoration: InputDecoration(hintText: 'Search'),
            onChanged: (username) {
              if (username.length > 0) {
                searchBloc.add(SearchUserRequested(username));
              }
            },
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UsersLoadSuccess) {
            List<User> users = state.users;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return SearchUserItem(user: users[index]);
                });
          }
          return Text('');
        }),
      ),
    );
  }
}

class SearchList {
  final List<SearchItem> searchList =
      List<SearchItem>.generate(10, (i) => SearchItem('User $i'));
}

class SearchItem {
  final String username;

  SearchItem(this.username);
}

class SearchUserItem extends StatelessWidget {
  User user;
  SearchUserItem({required this.user});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Room room = Room(RoomType.personalChat, [user, MyApp.currentUser], []);
        Navigator.of(context).pushNamed(ChatRoom.routeName, arguments: room);
      },
      child: Container(
        height: MediaQuery.of(context).size.width * 0.2,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: 50.0,
                    maxWidth: 50.0,
                    minWidth: 50.0,
                    minHeight: 50.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text("${user.username[0].toUpperCase()}")),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.blueAccent),
                )),
                child: Text("${user.username}"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

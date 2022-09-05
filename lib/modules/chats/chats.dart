import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/User/User_model.dart';
import 'package:social/modules/chat_detials/chat_details.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state) {
          var cubit = SocialCubit.get(context);
          if (cubit.users.isEmpty) {
            return const Center(child: Text('No Users'));
          }
          else {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  builtChatItem(cubit.users[index], context),
              separatorBuilder: (context, index) => builtDivider(),
              itemCount: cubit.users.length,
            );
          }
        }
    );
  }
  Widget builtChatItem(UserData model,context) =>InkWell(
    onTap:(){
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:[
           CircleAvatar(
            radius: 25.0,
            backgroundImage:NetworkImage(
              '${model.image}'
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

}

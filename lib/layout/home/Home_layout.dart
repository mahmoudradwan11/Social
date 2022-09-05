import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/newpost/posts.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){
          if(state is NewPostState)
          {
             navigateTo(context,NewPost());
          }
        },
        builder:(context,state)
      {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                cubit.titles[cubit.currentIndex]),
            actions:[
              IconButton(
                  onPressed:(){},
                  icon:const Icon(Icons.notification_important)),
              IconButton(
                  onPressed:(){},
                  icon:const Icon(Icons.search)),
            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.items,
            currentIndex: cubit.currentIndex,
            onTap:(index)
            {
               cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}

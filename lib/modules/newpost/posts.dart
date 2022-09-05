import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';

class NewPost extends StatelessWidget {
  NewPost({Key? key}) : super(key: key);
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state)
     {
       var cubit = SocialCubit.get(context);
       return Scaffold(
        appBar:defaultAppBar(
            context: context,
            title:'Create Post',
            actions: [
              tB(
                  text:'Post',
                  function:(){
                    var now = DateTime.now();
                    if(cubit.postImage==null)
                      {
                          cubit.createPost(
                              dateTime:now.toString(),
                              text: textController.text,
                          );
                      }

                    else
                    {
                      cubit.uploadPostImage(
                          dateTime:now.toString(),
                          text: textController.text,

                      );
                    }
                  }
              )
            ]
        ),
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if(state is SocialCreatePostLoadingState)
                const LinearProgressIndicator(),
              if(state is SocialCreatePostLoadingState)
                const SizedBox(
                height: 10.0,
              ),
              Row(
                children:const [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage:NetworkImage('https://img.freepik.com/free-photo/young-man-student-with-notebooks-showing-thumb-up-approval-smiling-satisfied-blue-studio-background_1258-65597.jpg?w=1060&t=st=1658322363~exp=1658322963~hmac=2a9bddec967c139e95bc10605221c2ac2feb5d75a22f1865b2cfba0147a38e7d'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child:Text(
                      'Mahmoud Radwan',
                      style: TextStyle(
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration:const InputDecoration(
                    hintText:'What is Your Mind...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if(cubit.postImage!=null)
                Stack(
                children: [
                  Container(
                      height:140,
                      width: double.infinity,
                      decoration:BoxDecoration(
                        image: DecorationImage(
                          image:FileImage(cubit.postImage!),
                          fit:BoxFit.cover,
                        ),
                        borderRadius:BorderRadius.circular(4.0),
                      ),
                  ),
                  IconButton(
                    onPressed:(){
                      cubit.removePostImage();
                    },
                    icon:const CircleAvatar(
                      radius: 20.0,
                      child:Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed:(){
                        cubit.getImagePost();
                      },
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                        Icon(
                            Icons.image),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                            'Add Photo'),
                      ],
                    ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed:(){},
                      child:const Text(
                          '# tags'
                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      );
      },
    );
  }
}

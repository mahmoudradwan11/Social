import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/User/User_model.dart';
import 'package:social/models/messagemodel.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/styles/colors/colors.dart';
class ChatDetailsScreen extends StatelessWidget {

  UserData? userModel;
  var textController = TextEditingController();
  ChatDetailsScreen({Key? key,
    this.userModel,
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder:(context)
        {
          SocialCubit.get(context).getMessages(receiverId:userModel!.uid!);
          return BlocConsumer<SocialCubit,SocialStates>(
            listener:(context,state){},
            builder:(context,state){
              var cubit = SocialCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children:[
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage:NetworkImage(userModel!.image!),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(userModel!.name!),
                    ],
                  ),
                ),
                body:Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:[
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                            itemBuilder:(context,index){
                              var massage = cubit.messages[index];
                              if(cubit.userModel!.uid! == massage.senderId) {
                                return builtMyMessage(massage);
                              }
                              return builtMessage(massage);
                            },
                            separatorBuilder:(context,index)=>const SizedBox(
                              height: 15.0,
                            ),
                            itemCount:cubit.messages.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:Colors.grey.withOpacity(0.3),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children:[
                            Expanded(
                              child: TextFormField(
                                controller: textController,
                                decoration:const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message ... ',
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color:defaultColor,
                              child: MaterialButton(
                                onPressed:(){
                                  cubit.sendMessage(
                                    receiverId:userModel!.uid!,
                                    dateTime:DateTime.now().toString(),
                                    text: textController.text,
                                  );
                                },
                                minWidth: 1.0,
                                child:const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }
  Widget builtMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:BoxDecoration(
        color: Colors.grey[300],
        borderRadius:const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topEnd:Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      padding:const EdgeInsets.symmetric(
        vertical:5.0,
        horizontal:10.0,
      ),
      child:Text(model.text!),
    ),
  );
  Widget builtMyMessage(MessageModel model)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:BoxDecoration(
        color:defaultColor.withOpacity(0.2),
        borderRadius:const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topEnd:Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      padding:const EdgeInsets.symmetric(
        vertical:5.0,
        horizontal:10.0,
      ),
      child:Text(model.text!),
    ),
  );
}

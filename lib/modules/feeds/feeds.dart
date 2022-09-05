import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/postmodel.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/styles/colors/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state) {
          var cubit = SocialCubit.get(context);
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.all(0.8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/young-student-woman-with-backpack-bag-holding-hand-with-thumb-up-gesture-isolated-white-wall_231208-11498.jpg?w=1060&t=st=1658321029~exp=1658321629~hmac=66ee71d06676751bd977daa5db7ee59eb69f6eb804f0fe62b1c26734aa7141be'),
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with Friends',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => builtPostItem(cubit.posts[index],context,index),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 0.8,
                    ),
                    itemCount: cubit.posts.length,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          }

    );
  }
  Widget builtPostItem(PostModel model,context,index)=> Card(
    margin:const EdgeInsets.symmetric(
        horizontal: 0.8
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
            children:[
              CircleAvatar(
                radius: 25.0,
                backgroundImage:NetworkImage('${model.image}'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Row(
                      children:[
                         Text(
                          '${model.name}',
                          style: const TextStyle(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              IconButton(
                onPressed:(){},
                icon:const Icon(Icons.more_horiz),
              ),
            ],
          ),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style:Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.black,
            )
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10,
          //     top: 5,
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end:6),
          //           child: Container(
          //             height: 20.0,
          //             child: MaterialButton(
          //               onPressed:(){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child:Text(
          //                   '#Software',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: Colors.blue,
          //                   )
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end:6),
          //           child: Container(
          //             height: 20.0,
          //             child: MaterialButton(
          //               onPressed:(){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child:Text(
          //                   '#Flutter',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: Colors.blue,
          //                   )
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
             Padding(
            padding:const EdgeInsetsDirectional.only(top: 15.0),
            child: Container(
                height:250,
                width: double.infinity,
                decoration:BoxDecoration(
                  image:DecorationImage(
                    image:NetworkImage(
                  '${model.postImage}'
                    ),
                    fit:BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                )
            ),
          ),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:5.0),
                      child: Row(
                        children:[
                          const Icon(Icons.favorite,
                            size: 18.0,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',style:Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                    onTap:(){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children:[
                          Icon(
                            Icons.comment,
                            size: 18.0,
                            color:defaultColor,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '120 comment',style:Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                    onTap:(){
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:[
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage:NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'write comment...',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  onTap:(){},
                ),
              ),
              InkWell(
                child: Row(
                  children:[
                    const Icon(Icons.favorite,
                      size: 18.0,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',style:Theme.of(context).textTheme.caption,)
                  ],
                ),
                onTap:(){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

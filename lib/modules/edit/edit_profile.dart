import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  EditProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state)
        {
          var cubit = SocialCubit.get(context);
          var userModel = cubit.userModel;
          var profileImage = cubit.profileImage;
          var coverImage = cubit.coverImage;
          nameController.text = userModel!.name!;
          bioController.text  =userModel.bio!;
          phoneController.text = userModel.phone!;
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Edit Profile',
                actions:[
                  tB(
                    text:'Update',
                    function:(){
                      cubit.updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                    },
                  ),
                  const SizedBox(
                    width: 15.0,
                  )
                ]
            ),
            body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:[
                    if(state is UserUpdateLoading)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              children: [
                                Container(
                                    height:140,
                                    width: double.infinity,
                                    decoration:BoxDecoration(
                                      image: DecorationImage(
                                        image:coverImage == null ? NetworkImage(
                                            '${userModel.cover}') : FileImage(coverImage) as ImageProvider ,
                                        fit:BoxFit.cover,
                                      ),
                                      borderRadius:const BorderRadius.only(
                                        topLeft:Radius.circular(4.0
                                        ),
                                        topRight: Radius.circular(4.0
                                        ),
                                      ),
                                    )
                                ),
                                IconButton(
                                    onPressed:(){
                                      cubit.getImageCover();
                                    },
                                    icon:const CircleAvatar(
                                      radius: 20.0,
                                      child:Icon(
                                          Icons.camera_alt,
                                      ),
                                    ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage:profileImage == null ? NetworkImage(
                                    '${userModel.image}') : FileImage(profileImage) as ImageProvider,
                                  ),
                                ),
                              IconButton(
                                onPressed:(){
                                  cubit.getImageProfile();
                                },
                                icon:const CircleAvatar(
                                  radius: 20.0,
                                  child:Icon(
                                    Icons.camera_alt,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        if(cubit.profileImage != null)
                          Expanded(
                          child: Column(
                            children: [
                              dB(
                                  function:(){
                                    cubit.uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text
                                    );
                                  },
                                  text:'upload profile'
                              ),
                              if(state is UserUpdateLoading)
                                 const SizedBox(
                                  height: 5.0,
                                 ),
                              if(state is UserUpdateLoading)
                                 const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if(cubit.coverImage != null)
                          Expanded(
                          child: Column(
                            children: [
                              dB(
                                  function:(){
                                    cubit.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text
                                    );
                                  },
                                  text:'upload cover '
                              ),
                              if(state is UserUpdateLoading)
                                  const SizedBox(
                                height: 5.0,
                              ),
                              if(state is UserUpdateLoading)
                                 const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    tFF(
                      show: false,
                      controller:nameController,
                      keyboard:TextInputType.name,
                      valid:(value)
                      {
                        if(value.isEmpty)
                        {
                          return 'Name Must not be Empty';
                        }
                        return null;
                      },
                      label:'Name',
                      prefix:Icons.person,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    tFF(
                      show: false,
                      controller:bioController,
                      keyboard:TextInputType.name,
                      valid:(value)
                      {
                        if(value.isEmpty)
                        {
                          return 'Bio Must not be Empty';
                        }
                        return null;
                      },
                      label:'Bio',
                      prefix:Icons.info,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    tFF(
                      show: false,
                      controller:phoneController,
                      keyboard:TextInputType.phone,
                      valid:(value)
                      {
                        if(value.isEmpty)
                        {
                          return 'Phone Must not be Empty';
                        }
                        return null;
                      },
                      label:'Phone',
                      prefix:Icons.mobile_friendly,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}

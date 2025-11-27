import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/widgets.dart';
import '../../../routes/pages.dart';
import '../../../utils/color_palette.dart';
import '../../../utils/font_sizes.dart';
import '../../../utils/util.dart';
import '../../data/model/task_model.dart';
import '../../data/provider/tasks_provider.dart';

class TaskItemView extends StatelessWidget {
  final String taskId;
  const TaskItemView({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Selector<TaskProvider, TaskModel?>(
      selector: (context, taskProvider) => taskProvider.getTaskById(taskId),
      builder: (context, taskModel, child) {
        if (taskModel == null) return const SizedBox(); //Task not found

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: taskModel.completed,
                onChanged: (value) {
                  var updated = TaskModel(
                    id: taskModel.id,
                    title: taskModel.title,
                    description: taskModel.description,
                    completed: value ?? false,
                    startDateTime: taskModel.startDateTime,
                    stopDateTime: taskModel.stopDateTime,
                  );
                  context.read<TaskProvider>().updateTask(updated);
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildText(
                            taskModel.title,
                            taskModel.completed ? kGrey1 : kBlackColor,
                            textMedium,
                            FontWeight.w500,
                            TextAlign.start,
                            TextOverflow.clip,
                          ),
                        ),
                        PopupMenuButton<int>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: kWhiteColor,
                          elevation: 1,
                          onSelected: (value) {
                            switch (value) {
                              case 0:
                                Navigator.of(context).pushNamed(
                                  Pages.updateTask,
                                  arguments: taskModel,
                                );
                                break;
                              case 1:
                                context
                                    .read<TaskProvider>()
                                    .deleteTask(taskModel.id);
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svgs/edit.svg',
                                      width: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    buildText(
                                      'Edit task',
                                      kBlackColor,
                                      textMedium,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 1,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svgs/delete.svg',
                                      width: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    buildText(
                                      'Delete task',
                                      kRed,
                                      textMedium,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                            ];
                          },
                          child:
                              SvgPicture.asset('assets/svgs/vertical_menu.svg'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    buildText(
                      taskModel.description,
                      kGrey1,
                      textSmall,
                      FontWeight.normal,
                      TextAlign.start,
                      TextOverflow.clip,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svgs/calender.svg',
                              width: 12),
                          const SizedBox(width: 10),
                          Expanded(
                            child: buildText(
                              '${formatDate(dateTime: taskModel.startDateTime.toString())} - ${formatDate(dateTime: taskModel.stopDateTime.toString())}',
                              taskModel.completed ? kGrey1 : kBlackColor,
                              textTiny,
                              FontWeight.w400,
                              TextAlign.start,
                              TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_app/components/custom_app_bar.dart';
import 'package:task_manager_app/tasks/data/local/model/task_model.dart';
import 'package:task_manager_app/tasks/data/provider/tasks_provider.dart';
import 'package:task_manager_app/components/build_text_field.dart';
import 'package:task_manager_app/tasks/presentation/widget/task_item_view.dart';
import 'package:task_manager_app/utils/color_palette.dart';

import '../../../components/widgets.dart';
import '../../../routes/pages.dart';
import '../../../utils/font_sizes.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: CustomAppBar(
          title: 'Hi Asim',
          showBackArrow: false,
          actionWidgets: [
            PopupMenuButton<int>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 1,
              onSelected: (value) {
                context.read<TaskProvider>().setSortOption(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/calender.svg',
                          width: 15,
                        ),
                        const SizedBox(width: 10),
                        buildText(
                          'Sort by date',
                          kBlackColor,
                          textSmall,
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
                          'assets/svgs/task_checked.svg',
                          width: 15,
                        ),
                        const SizedBox(width: 10),
                        buildText(
                          'Completed tasks',
                          kBlackColor,
                          textSmall,
                          FontWeight.normal,
                          TextAlign.start,
                          TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgs/task.svg', width: 15),
                        const SizedBox(width: 10),
                        buildText(
                          'Pending tasks',
                          kBlackColor,
                          textSmall,
                          FontWeight.normal,
                          TextAlign.start,
                          TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ];
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset('assets/svgs/filter.svg'),
              ),
            ),
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Selector<TaskProvider, bool>(
              selector: (context, taskProvider) => taskProvider.isLoading,
              builder: (context, isLoading, child) {
                if (isLoading)
                  return const Center(child: CupertinoActivityIndicator());
                return child!;
              },
              child: Column(
                children: [
                  _SearchField(searchController: _searchController),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Selector<TaskProvider, List<TaskModel>>(
                      selector: (context, taskProvider) =>
                          taskProvider.displayTasks,
                      shouldRebuild: (previous, next) {
                        if (previous.length != next.length) return true;
                        for (int i = 0; i < previous.length; i++) {
                          if (previous[i].id != next[i].id) return true;
                        }
                        return false;
                      },
                      builder: (context, displayTasks, child) {
                        final hasAnyTasks =
                            context.read<TaskProvider>().tasks.isNotEmpty;
                        final isSearching =
                            context.read<TaskProvider>().searchQuery.isNotEmpty;

                        if (!hasAnyTasks) return _buildInitialEmptyState(size);
                        if (displayTasks.isEmpty && isSearching)
                          return _buildSearchEmptyState(
                              size, _searchController);

                        return _TaskListWidget(displayTasks: displayTasks);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_circle, color: kPrimaryColor),
          onPressed: () {
            Navigator.pushNamed(context, Pages.createNewTask);
          },
        ),
      ),
    );
  }

  Widget _buildInitialEmptyState(Size size) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svgs/tasks.svg',
            height: size.height * .20,
            width: size.width,
          ),
          const SizedBox(height: 50),
          buildText(
            'Schedule your tasks',
            kBlackColor,
            textBold,
            FontWeight.w600,
            TextAlign.center,
            TextOverflow.clip,
          ),
          buildText(
            'Manage your task schedule easily\nand efficiently',
            kBlackColor.withOpacity(.5),
            textSmall,
            FontWeight.normal,
            TextAlign.center,
            TextOverflow.clip,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchEmptyState(Size size, TextEditingController controller) {
    return Column(
      children: [
        BuildTextField(
          hint: "Search recent task",
          controller: controller,
          inputType: TextInputType.text,
          prefixIcon: const Icon(
            Icons.search,
            color: kGrey2,
          ),
          fillColor: kWhiteColor,
          onChange: (value) {
            context.read<TaskProvider>().setSearchQuery(value);
          },
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svgs/tasks.svg',
                  height: size.height * .15,
                ),
                const SizedBox(height: 20),
                buildText(
                  'No tasks found',
                  kBlackColor,
                  textMedium,
                  FontWeight.w600,
                  TextAlign.center,
                  TextOverflow.clip,
                ),
                buildText(
                  'Try different keywords',
                  kGrey1,
                  textSmall,
                  FontWeight.normal,
                  TextAlign.center,
                  TextOverflow.clip,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController searchController;

  const _SearchField({required this.searchController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildTextField(
      hint: "Search recent task",
      controller: searchController,
      inputType: TextInputType.text,
      prefixIcon: const Icon(Icons.search, color: kGrey2),
      fillColor: kWhiteColor,
      onChange: (value) {
        context.read<TaskProvider>().setSearchQuery(value);
      },
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  final List<TaskModel> displayTasks;

  const _TaskListWidget({required this.displayTasks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: displayTasks.length,
      itemBuilder: (context, index) {
        return TaskItemView(taskId: displayTasks[index].id);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: kGrey3);
      },
    );
  }
}

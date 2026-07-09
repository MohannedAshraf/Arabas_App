// ignore_for_file: unused_element_parameter, use_build_context_synchronously

import 'package:arabas_app/core/theme/app_colors.dart';
import 'package:arabas_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/delete_notification_cubit.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/delete_notification_state.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/notification_cubit.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/notification_state.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/read_notification_cubit.dart';
import 'package:arabas_app/features/notifications/presentation/bloc/read_notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();

    context.read<NotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الإشعارات",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: BackButton(color: AppColors.primary),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReadNotificationCubit, ReadNotificationState>(
            listener: (context, state) {
              if (state is ReadNotificationSuccess) {
                context.read<NotificationCubit>().markAsRead(state.id);
              }

              if (state is ReadNotificationError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),

          BlocListener<DeleteNotificationCubit, DeleteNotificationState>(
            listener: (context, state) {
              if (state is DeleteNotificationSuccess) {
                context.read<NotificationCubit>().removeNotification(state.id);
              }

              if (state is DeleteNotificationError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
        ],
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NotificationError) {
              return Center(child: Text(state.error));
            }

            final data =
                state is NotificationSuccess
                    ? state.data
                    : (state as NotificationPaginationLoading).oldData;
            if (data.notifications.isEmpty) {
              return Center(
                child: Text(
                  "لا توجد إشعارات",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: context.read<NotificationCubit>().refresh,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: data.notifications.length,
                      itemBuilder: (context, index) {
                        return _NotificationCard(
                          notification: data.notifications[index],
                          onTap: () {
                            if (!data.notifications[index].isRead) {
                              context
                                  .read<ReadNotificationCubit>()
                                  .readNotification(
                                    data.notifications[index].id,
                                  );
                            }
                          },
                          onDelete: () async {
                            final bool? confirm = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  title: Text(
                                    "حذف الإشعار",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    "هل تريد حذف هذا الإشعار؟",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext, false);
                                      },
                                      child: Text(
                                        "لا",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext, true);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: Text(
                                        "نعم",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirm == true) {
                              context
                                  .read<DeleteNotificationCubit>()
                                  .deleteNotification(
                                    data.notifications[index].id,
                                  );
                            }
                          },
                        );
                      },
                    ),
                  ),

                  _PaginationSection(
                    currentPage: data.pageNumber,
                    totalPages: data.totalPages,
                  ),

                  SizedBox(height: 10.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        notification.title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        notification.body,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 12.sp,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Row(
                        children: [
                          InkWell(
                            onTap: onDelete,
                            borderRadius: BorderRadius.circular(8.r),
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 20.sp,
                              ),
                            ),
                          ),

                          const Spacer(),

                          Text(
                            timeAgo(notification.createdAt),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color:
                        notification.isRead
                            ? Colors.grey.shade200
                            : const Color(0xffE8D7E0),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.notifications,
                    color:
                        notification.isRead ? Colors.grey : AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          if (!notification.isRead)
            Positioned(
              top: 8.h,
              left: 8.w,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PaginationSection extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _PaginationSection({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          final page = index + 1;

          final isSelected = page == currentPage;

          return InkWell(
            onTap: () {
              context.read<NotificationCubit>().getNotifications(page: page);
            },
            child: Container(
              width: 38.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  page.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemCount: totalPages,
      ),
    );
  }
}

String timeAgo(String date) {
  final notificationDate = DateTime.parse(date).toLocal();
  final difference = DateTime.now().difference(notificationDate);

  if (difference.inSeconds < 60) {
    return "الآن";
  }

  if (difference.inMinutes < 60) {
    return "منذ ${difference.inMinutes} دقيقة";
  }

  if (difference.inHours < 24) {
    return "منذ ${difference.inHours} ساعة";
  }

  if (difference.inDays == 1) {
    return "أمس";
  }

  if (difference.inDays < 7) {
    return "منذ ${difference.inDays} أيام";
  }

  if (difference.inDays < 30) {
    return "منذ ${(difference.inDays / 7).floor()} أسبوع";
  }

  if (difference.inDays < 365) {
    return "منذ ${(difference.inDays / 30).floor()} شهر";
  }

  return "منذ ${(difference.inDays / 365).floor()} سنة";
}

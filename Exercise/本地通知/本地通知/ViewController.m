//
//  ViewController.m
//  本地通知
//
//  Created by healthme009 on 2017/5/9.
//  Copyright © 2017年 healthm. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <EventKit/EventKit.h>
#import "NSDate+dateComponent.h"

@interface ViewController () 

@end

/*** 本地通知的id ***/
static NSString *requestIdentifier = @"LocalNotification_test";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 获取提醒的时间
    //    NSDateFormatter *dmf = [[NSDateFormatter alloc] init];
    //    dmf.dateFormat = @"HH:mm";
    ////    dmf.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //    NSDate *date = [dmf dateFromString:model.time];
    //    // 将世界时间转换为中国时间
    //    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    //    NSInteger tl = [tz secondsFromGMTForDate:date];
    //    date = [date dateByAddingTimeInterval:tl];
    
    NSDateFormatter *dfm = [[NSDateFormatter alloc] init];
    dfm.dateFormat = @"HH:mm:ss";
    NSString *dateString = @"12:34:58";
    NSDate *date = [dfm dateFromString:dateString];
//    NSLog(@"%@", dateString);
    
    NSLog(@"%ld",date.hour);
    NSLog(@"%ld",date.minute);
    NSLog(@"%ld",date.second);
    
}
- (IBAction)clock:(id)sender {
    
    [self addEventNotify:[NSDate dateWithTimeIntervalSinceNow:5] title:@"测试事件"];
    
}

-(void)addEventNotify:(NSDate *)date title:(NSString *)title

{
    //生成事件数据库对象
    
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    //申请事件类型权限
    
    [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) { //授权是否成功
            
            EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB]; //创建一个日历事件
            
            myEvent.title     = title;  //标题
            
            myEvent.startDate = date; //开始date   required
            
            myEvent.endDate   = date;  //结束date    required
            
            [myEvent addAlarm:[EKAlarm alarmWithAbsoluteDate:date]]; //添加一个闹钟  optional
            
            [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]]; //添加calendar  required
            
            NSError *err;
            
            [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err]; //保存
            
        }
        
    }];
    
}

-(void)addReminderNotify:(NSDate *)date title:(NSString *)title

{
    
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    //申请提醒权限
    
    [eventDB requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) {
            //创建一个提醒功能
            
            EKReminder *reminder = [EKReminder reminderWithEventStore:eventDB];
            //标题
            
            reminder.title = title;
            //添加日历
            
            [reminder setCalendar:[eventDB defaultCalendarForNewReminders]];
            
            NSCalendar *cal = [NSCalendar currentCalendar];
            
            [cal setTimeZone:[NSTimeZone systemTimeZone]];
            
            NSInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth |
            
            NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute |
            
            NSCalendarUnitSecond;
            
            NSDateComponents* dateComp = [cal components:flags fromDate:date];
            
            dateComp.timeZone = [NSTimeZone systemTimeZone];
            
            reminder.startDateComponents = dateComp; //开始时间
            
            reminder.dueDateComponents = dateComp; //到期时间
            
            reminder.priority = 1; //优先级
            
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:date]; //添加一个车闹钟
            
            [reminder addAlarm:alarm];
            
            NSError *err;
            
            [eventDB saveReminder:reminder commit:YES error:&err];
            
            if (err) {
                
                
            }
            
        }
        
    }];
    
}



- (IBAction)openLocalNotification:(id)sender {
    
//    [[UNUserNotificationCenter currentNotificationCenter] ];
//    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
//
    
    // 1. 创建通知内容（还可添加附件attachments）
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"test local notification";
    content.subtitle = @"sub title";
    content.body = @"remember open the door";
    content.badge = @1;
    content.sound = [UNNotificationSound defaultSound]; // 通知提示音
    content.userInfo = @{@"key" : @"UNNUerInfo++++++++"};
    
    // 2. 触发模式
    UNNotificationTrigger *trigger = nil;
//    trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.hour = 10;
    dateComponents.minute = 27;
    dateComponents.weekday = 6 | 7 | 1 | 2;

    trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:YES];
    
    // 3. 创建UNNotificationRequest
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    
    
    // 2. 将UNNotificationRequest类添加到当前通知中心中
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
    NSLog(@"%@", [[UIApplication sharedApplication] scheduledLocalNotifications]);
    
    
    
//    NSDate *now = [NSDate date];
//    //取得系统时间
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute;
//    components = [calendar components:unitFlags fromDate:now];
////    NSInteger hour = [components hour];
////    NSInteger min = [components minute];
////    NSInteger sec = [components second];
////    NSInteger week = [components weekday];
////    NSLog(@"现在是%ld：%ld：%ld,周%ld",hour,min,sec,week - 1);
//    
////    components.weekday = 6;
////    components.hour = 15;
////    components.minute = 21;
//    [components setHour:15];
//    [components setMinute:36];
//    [components setWeekday:6];
//    
//    NSDate *date = [calendar dateFromComponents:components];
//    NSTimeZone *tz = [NSTimeZone systemTimeZone];
//    NSInteger tl = [tz secondsFromGMTForDate:date];
//    date = [date dateByAddingTimeInterval:tl];
//    
//    UILocalNotification *localNote = [self oneTimeNotification];
//    localNote.fireDate = date;
//    localNote.repeatInterval = NSCalendarUnitWeekday;
//    
//    
//    // 重复的日期
////    localNote.repeatCalendar = calender;
//    
//    
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
}

- (UILocalNotification *)oneTimeNotification {
    // 1. 创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    
    // 2. 设置本地通知内容
    // 2.1 时间
//    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
//    localNote.repeatInterval = 0;  // 不重复
    
    // 2.2 内容
    localNote.alertBody = @"tixingnia";
    
    // 2.3 滑块文字
    localNote.alertAction = @"";
    
    // 2.4 alertAction是否生效
    [localNote setHasAction:YES];
    
    // 2.5 点击通知的启动图片
    localNote.alertLaunchImage = @"";
    
    // 2.6 标题
    localNote.alertTitle = @"全民健康";
    
    // 2.7 声音
    localNote.soundName = UILocalNotificationDefaultSoundName;
    
    // 2.8 应用角标数字
    localNote.applicationIconBadgeNumber = 1;
    
    // 2.9 额外信息
    localNote.userInfo = @{};
    
    return localNote;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

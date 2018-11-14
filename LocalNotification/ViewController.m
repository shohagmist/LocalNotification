//
//  ViewController.m
//  LocalNotification
//
//  Created by SHS on 11/14/18.
//  Copyright © 2018 SHS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

BOOL isGrantedNotAccess;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    isGrantedNotAccess = false;
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        self->isGrantedNotAccess = granted;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)notify:(UIButton *)sender {
    
    if(isGrantedNotAccess)
    {
        [self fireNotificationAtSpecificTimeDaily];
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
        
        content.title = @"Medicine Reminder";
        content.subtitle = @"Your Health Partner";
        content.body = @"It is 2nd Time For Your Medicine";
        content.sound = [UNNotificationSound defaultSound];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:30 repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"MedicineReminder" content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
    }

}

- (void) fireNotificationAtSpecificTimeDaily
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:20];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components: NSCalendarUnitHour + NSCalendarUnitMinute +
                                     NSCalendarUnitSecond fromDate:date];
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:YES];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title = @"Medicine Reminder";
    content.subtitle = @"Your Health Partner";
    content.body = @"It is Time For Your Medicine";
    content.sound = [UNNotificationSound defaultSound];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"MedicineReminder" content:content trigger:trigger];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
}

@end

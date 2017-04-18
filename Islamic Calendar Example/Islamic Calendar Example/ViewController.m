//
//  ViewController.m
//  Islamic Calendar Example
//
//  Created by Bisma on 10/04/2017.
//  Copyright © 2017 Bisma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BSIslamicCalendar *calendar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSIslamicCalendar *newCalendar=[[BSIslamicCalendar alloc] initWithFrame:CGRectMake(10, 50, 355, 355)];
    newCalendar.delegate=self;
    [self.view addSubview:newCalendar];
    
    [newCalendar setIslamicDatesInArabicLocale:YES];
    [newCalendar setShowIslamicMonth:YES];
}


#pragma mark - Calendar Delegate
-(BOOL)islamicCalendar:(BSIslamicCalendar *)calendar shouldSelectDate:(NSDate *)date{
    
    // e.g. Don't select if it's today
    if ([calendar compareDate:date withDate:[NSDate date]]) {
        
        return NO;
    }else{
        
        return YES;
    }
}
-(void)islamicCalendar:(BSIslamicCalendar *)calendar dateSelected:(NSDate *)date withSelectionArray:(NSArray *)selectionArry{
    
    NSLog(@"selections: %@",selectionArry);
}


@end

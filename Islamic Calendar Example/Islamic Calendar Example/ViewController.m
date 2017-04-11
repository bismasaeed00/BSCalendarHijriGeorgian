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
    [self.view addSubview:newCalendar];
    
    [newCalendar setIslamicDatesInArabicLocale:YES];
    [newCalendar setShowIslamicMonth:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

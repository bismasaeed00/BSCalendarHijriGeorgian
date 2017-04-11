//
//  BSIslamicCalendar.h
//  Islamic Calendar Example
//
//  Created by Bisma on 10/04/2017.
//  Copyright © 2017 Bisma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSIslamicCalendar : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

#pragma mark - Initializers
-(id)init;
-(id)initWithFrame:(CGRect)frame;

#pragma mark - Set properties
-(void)setShortInitials:(BOOL)isShort;
-(void)setShowIslamicMonth:(BOOL)isIslamic;
-(void)setIslamicDatesInArabicLocale:(BOOL)isArabic;

#pragma mark - Set Colors
-(void)setDateTextColor:(UIColor*)color;
-(void)setDateBGColor:(UIColor*)color;
-(void)setDaysNameColor:(UIColor*)color;
-(void)setSelectedDateTextColor:(UIColor*)color;
-(void)setCurrentDateTextColor:(UIColor*)color;
-(void)setCurrentDateBGColor:(UIColor*)color;

@end

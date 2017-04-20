//
//  BSIslamicCalendar.m
//  Islamic Calendar Example
//
//  Created by Bisma on 10/04/2017.
//  Copyright © 2017 Bisma. All rights reserved.
//

#import "BSIslamicCalendar.h"
#import "BSIslamicCalendarCell.h"

@implementation BSIslamicCalendar{
    
    NSInteger startIndex;
    NSDate *calForDate;
    NSDateComponents *components;
    NSRange rangeOfDaysThisMonth;
    NSCalendar *gregorian;
    NSInteger rowCount;
    NSMutableArray *datesArry;
    UICollectionView *collectionVew;
    
    UIColor *dateTextColor;
    UIColor *daysNameColor;
    UIColor *dateBGColor;
    UIColor *selectedDateBGColor;
    UIColor *currentDateTextColor;
    
    UIButton *btnNext;
    UIButton *btnPrevious;
    UILabel *lblMonth;
    
    BOOL isShortInitials;
    BOOL isIslamicMonth;
    BOOL isArabicLocale;
    
    NSMutableArray *selectionArry;
    
}
-(id)init{
    
    if (self=[super init]) {
        
        self.frame=CGRectMake(20, 20, 300, 300);

        [self initializeIslamicCalendar];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.frame=frame;
        if (frame.size.width>0) {
            
            [self initializeIslamicCalendar];
        }
    }
    return self;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self initializeIslamicCalendar];
}
-(void)initializeIslamicCalendar{

    CGRect rect = self.frame;
    rect.origin.x=0;
    rect.size.height=rect.size.height-40;
    
    float width=rect.size.width-30;
    float height=rect.size.height-30;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake(width/7.0, height/7.0);
    flowLayout.minimumLineSpacing=3.0;
    flowLayout.minimumInteritemSpacing=3.0;
    
    collectionVew=[[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
    collectionVew.showsVerticalScrollIndicator=NO;
    collectionVew.showsHorizontalScrollIndicator=NO;
    
    collectionVew.delegate=self;
    collectionVew.dataSource=self;
    
    collectionVew.backgroundColor=[UIColor clearColor];
    
    [self addSubview:collectionVew];
    
    [collectionVew registerNib:[UINib nibWithNibName:@"BSIslamicCalendarCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    lblMonth=[[UILabel alloc] initWithFrame:CGRectMake((rect.size.width-100)*0.5, 0, 100, 40)];
    [lblMonth setFont:[UIFont systemFontOfSize:14]];
    lblMonth.textAlignment=NSTextAlignmentCenter;
    [self addSubview:lblMonth];
    
    btnNext=[[UIButton alloc] initWithFrame:CGRectMake(lblMonth.frame.origin.x+lblMonth.frame.size.width+8, 0, 50, 40)];
    [btnNext setTitle:@"Next" forState:UIControlStateNormal];
    [btnNext setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btnNext.titleLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:btnNext];
    
    [btnNext addTarget:self action:@selector(nextBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    btnPrevious=[[UIButton alloc] initWithFrame:CGRectMake(lblMonth.frame.origin.x-58, 0, 50, 40)];
    [btnPrevious setTitle:@"Previous" forState:UIControlStateNormal];
    [btnPrevious setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btnPrevious.titleLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:btnPrevious];
    
    [btnPrevious addTarget:self action:@selector(previousBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    dateTextColor=[UIColor whiteColor];
    dateBGColor=[UIColor lightGrayColor];
    daysNameColor=[UIColor blackColor];
    selectedDateBGColor=[UIColor magentaColor];
    currentDateTextColor=[UIColor blueColor];
    
    calForDate = [NSDate date];
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:[NSTimeZone systemTimeZone]];
    
    rangeOfDaysThisMonth = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:calForDate];
    
    components = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra) fromDate:calForDate];
    
    [components setTimeZone:[NSTimeZone systemTimeZone]];
    
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    rowCount=7;
    
    selectionArry=[[NSMutableArray alloc] init];
    
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    [self setUpIndexs:0];
}
#pragma mark CollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return rowCount*7;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BSIslamicCalendarCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCellLabels:cell.lblTitle detailLabel:cell.lblDetail atIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item>7 && indexPath.item>=startIndex && datesArry.count>indexPath.item-startIndex) {
    
    NSDate *date=[datesArry objectAtIndex:indexPath.item-startIndex];
    
        if ([self.delegate respondsToSelector:@selector(islamicCalendar:shouldSelectDate:)]) {
        
            if ([self.delegate islamicCalendar:self shouldSelectDate:date]) {
                
                [self updateSelectionForDate:date];
                [self.delegate islamicCalendar:self dateSelected:date withSelectionArray:selectionArry];
            }
            
        }else{
            
            [self updateSelectionForDate:date];
        }
        
    }
    
}
-(void)updateSelectionForDate:(NSDate*)date{
    
    if ([selectionArry containsObject:date]) {
        
        [selectionArry removeObject:date];
    }else{
        [selectionArry addObject:date];
    }
    
    [collectionVew reloadData];
}
-(void)configureCellLabels:(UILabel*)titelLbl detailLabel:(UILabel *)detailLbl atIndexPath:(NSIndexPath*)indexPath{

    UICollectionViewFlowLayout *flowLayout=(UICollectionViewFlowLayout*)[collectionVew collectionViewLayout];
    
    if (indexPath.item<7) {
    
        titelLbl.superview.backgroundColor=[UIColor clearColor];
        titelLbl.frame=CGRectMake(4, 0, flowLayout.itemSize.width-8, flowLayout.itemSize.height);
        detailLbl.frame=CGRectMake(0,0,0,0);
        detailLbl.text=@"";
        
        NSString *dayName;
        
        switch (indexPath.item) {
            case 0:
                
                dayName=@"Mon";
                break;
            case 1:
                
                dayName=@"Tue";
                break;
            case 2:
                
                dayName=@"Wed";
                break;
            case 3:
                
                dayName=@"Thu";
                break;
            case 4:
                
                dayName=@"Fri";
                break;
            case 5:
                
                dayName=@"Sat";
                break;
            case 6:
                
                dayName=@"Sun";
                break;
                
            default:
                break;
        }
        
        if (isShortInitials) {
            
            dayName=[dayName substringToIndex:1];
        }
        titelLbl.text=dayName;
        
        if ([self todayDayName:indexPath]) {
            
            titelLbl.textColor=currentDateTextColor;
            detailLbl.textColor=currentDateTextColor;
        }else{
            titelLbl.textColor=daysNameColor;
            detailLbl.textColor=dateTextColor;
        }
        
    }else{
        
        titelLbl.superview.backgroundColor=dateBGColor;
        titelLbl.frame=CGRectMake(4, 0, flowLayout.itemSize.width-8, flowLayout.itemSize.height*0.5);
        detailLbl.frame=CGRectMake(4, flowLayout.itemSize.height*0.5, flowLayout.itemSize.width-12, flowLayout.itemSize.height*0.5);
        
        if (indexPath.item>=startIndex && datesArry.count>indexPath.item-startIndex) {
            
            NSDate *date=[datesArry objectAtIndex:indexPath.item-startIndex];
            
            
            if ([self compareDate:date withDate:[NSDate date]]) {
                
                titelLbl.textColor=currentDateTextColor;
                detailLbl.textColor=currentDateTextColor;
                
            }else{
                titelLbl.textColor=dateTextColor;
                detailLbl.textColor=dateTextColor;
            }
            
            if ([selectionArry containsObject:date]) {
                
                titelLbl.superview.backgroundColor=selectedDateBGColor;
                
            }else{
                
                titelLbl.superview.backgroundColor=dateBGColor;
            }
            
            titelLbl.text=[self getGregorianDayFromDate:date];
            detailLbl.text=[self getIslamicDayFromDate:date];
            
        }else{
            
            titelLbl.text=@"";
            detailLbl.text=@"";
        }
        
        
    }
    
}

-(void)setUpIndexs:(NSInteger)num{
    
    
    components = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra) fromDate:calForDate];
    [components setDay:1];
    
    [components setMonth:components.month+num];
    
    if (components.month>12) {
        
        [components setMonth:1];
        [components setYear:components.year+1];
        
    }else if (components.month<=0){
        
        [components setMonth:12];
        [components setYear:components.year-1];
        
    }
    
    calForDate=[gregorian dateFromComponents:components];
    
    rangeOfDaysThisMonth = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:calForDate];
    
    datesArry=[[NSMutableArray alloc] init];
    for (NSInteger i = rangeOfDaysThisMonth.location; i < NSMaxRange(rangeOfDaysThisMonth); ++i) {
        [components setDay:i];
        NSDate *dayInMonth = [gregorian dateFromComponents:components];
        [datesArry addObject:dayInMonth];
    }
    
    
    if (datesArry.count>0) {
        
        NSDate *firstDate=[datesArry objectAtIndex:0];
         NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        
        if (isIslamicMonth) {
            
            NSCalendar *islamicCalander = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
             [dateFormatter setCalendar:islamicCalander];
            [dateFormatter setDateFormat:@"MMMM YYYY"];
        }else{
            
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
            [dateFormatter setDateFormat:@"MMMM"];
        }
        
        lblMonth.text=[[dateFormatter stringFromDate:firstDate] uppercaseString];
        
        components=[gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra | NSCalendarUnitWeekday) fromDate:firstDate];
        startIndex = (((components.weekday + 5) % 7) + 1)+6;
        
    }
    
    float tempCount=(startIndex+datesArry.count)/7.0;
    rowCount=ceil(tempCount);
    [collectionVew reloadData];
}


-(BOOL)compareDate:(NSDate*)date1 withDate:(NSDate*)date2{
    
    NSDateComponents *comp1 = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date1];
    
    NSDateComponents *comp2 = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date2];
    
    if (comp1.day==comp2.day && comp1.month==comp2.month && comp1.year==comp2.year) {
        
        return YES;
    }else{
        return false;
    }
    
}

-(NSString*)getGregorianDayFromDate:(NSDate*)date{
    
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitDay) fromDate:date];
    
    NSString *retStr=[NSString stringWithFormat:@"%li",(long)comp.day];
    return retStr;
}
-(NSString*)getIslamicDayFromDate:(NSDate*)date{
    
    NSCalendar *islamicCalander = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    NSDateComponents *comp = [islamicCalander components:(NSCalendarUnitDay) fromDate:date];
    
    NSString *retStr=[NSString stringWithFormat:@"%li",(long)comp.day];
    
    if (isArabicLocale) {
        
        NSDecimalNumber *someNumber = [NSDecimalNumber decimalNumberWithString:retStr];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSLocale *gbLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar_SA"];
        [formatter setLocale:gbLocale];
        retStr = [formatter stringFromNumber:someNumber];
    }
    
    return retStr;
}
-(BOOL)todayDayName:(NSIndexPath *)indexPath{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E"];
    [dateFormatter setTimeZone: [NSTimeZone systemTimeZone]];
    NSString *currDayName = [dateFormatter stringFromDate:[NSDate date]];
    
    if ([currDayName isEqualToString:@"Mon"] && indexPath.item==0) {
        
        return YES;
    }else if ([currDayName isEqualToString:@"Tue"] && indexPath.item==1) {
        
        return YES;
    }else if ([currDayName isEqualToString:@"Wed"] && indexPath.item==2) {
        
        return YES;
    }else if ([currDayName isEqualToString:@"Thu"] && indexPath.item==3) {
        
        return YES;
    }else if ([currDayName isEqualToString:@"Fri"] && indexPath.item==4) {
        
        return YES;
    }else if ([currDayName isEqualToString:@"Sat"] && indexPath.item==5) {
        
        return YES;
    }else if ([currDayName isEqualToString:@"Sun"] && indexPath.item==6) {
        
        return YES;
    }else{
        return NO;
    }
}

-(void)previousBtnPressed:(UIButton*)btn{
    
    [selectionArry removeAllObjects];
    [self setUpIndexs:-1];
}
-(void)nextBtnPressed:(UIButton*)btn{
    
    [selectionArry removeAllObjects];
    [self setUpIndexs:+1];
}

#pragma mark - Set properties
-(void)setShortInitials:(BOOL)isShort{
    
    isShortInitials=isShort;
    [collectionVew reloadData];
}
-(void)setShowIslamicMonth:(BOOL)isIslamic{
    
    isIslamicMonth=isIslamic;
    [self setUpIndexs:0];
}
-(void)setIslamicDatesInArabicLocale:(BOOL)isArabic;{
    
    isArabicLocale=isArabic;
    [collectionVew reloadData];
}

#pragma mark - Set Colors
-(void)setDateTextColor:(UIColor*)color{
    
    dateTextColor=color;
    [collectionVew reloadData];
}
-(void)setDateBGColor:(UIColor*)color{
    
    dateBGColor=color;
    [collectionVew reloadData];
}
-(void)setDaysNameColor:(UIColor*)color{
    
    daysNameColor=color;
    [collectionVew reloadData];
}
-(void)setSelectedDateBGColor:(UIColor*)color{
    
    selectedDateBGColor=color;
    [collectionVew reloadData];
}
-(void)setCurrentDateTextColor:(UIColor*)color{
    
    currentDateTextColor=color;
    [collectionVew reloadData];
}

-(NSArray*)getSelectedDates{
    
    return selectionArry;
}
@end

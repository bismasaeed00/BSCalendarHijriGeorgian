# BSIslamicCalendar
It can show Georgian and Islamic dates in calendar.  

![alt tag](https://cloud.githubusercontent.com/assets/16186934/25127517/9283fb82-244f-11e7-9b8b-38058479c244.png)

## How To Get Started
Download the project and drag files of BSIslamicCalendar in you project. Don't forgot to import
```
#import "BSIslamicCalendar.h"
```
Now, you can create an instance of calendar and add it to your view like that,
```
BSIslamicCalendar *newCalendar=[[BSIslamicCalendar alloc] initWithFrame:CGRectMake(10, 50, 355, 355)];
[self.view addSubview:newCalendar];
```
or you can place a view into your storyboard and set it's class to BSIslamicCalendar.

### Customization
All the text and background colors can be customized

```
-(void)setDateTextColor:(UIColor*)color;
-(void)setDateBGColor:(UIColor*)color;
-(void)setDaysNameColor:(UIColor*)color;
-(void)setSelectedDateBGColor:(UIColor*)color;
-(void)setCurrentDateTextColor:(UIColor*)color;
```
You can also set islamic dates to arabic locale by using this line:
```
[newCalendar setIslamicDatesInArabicLocale:YES];
```
## UPDATE
Implement the delegate to get selected dates. 
```
-(BOOL)islamicCalendar:(BSIslamicCalendar*)calendar shouldSelectDate:(NSDate*)date;
-(void)islamicCalendar:(BSIslamicCalendar*)calendar dateSelected:(NSDate*)date withSelectionArray:(NSArray*)selectionArry;
```

Happy Codding!!!1

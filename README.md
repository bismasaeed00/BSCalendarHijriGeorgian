# BSIslamicCalendar
It can show Georgian and Islamic dates in calendar.  

![alt tag](https://cloud.githubusercontent.com/assets/16186934/24908561/e4246344-1ed9-11e7-8bfe-8120568a6a60.png)

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
-(void)setSelectedDateTextColor:(UIColor*)color;
-(void)setCurrentDateTextColor:(UIColor*)color;
-(void)setCurrentDateBGColor:(UIColor*)color;
```
You can also set islamic dates to arabic locale by using this line:
```
[newCalendar setIslamicDatesInArabicLocale:YES];
```
Currently, it's just displaying date. I'll add selection of dates soon.

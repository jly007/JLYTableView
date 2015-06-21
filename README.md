JLYTableView
============

* JLYTalbeView is a powerful implementation based on UITableView.
* It provides some interesting features, such as：multi-column display.
* Users can customize the tap event with each cell. 
* Special thanks to my friends. 

![image](https://github.com/jly007/JLYTableView/blob/master/ScreemShot/ScreemShot.png)

# Usage 

As simple as

```objc
#import "ViewController.h"
#import "JLYData.h"
#import "JLYTableView.h"
#import "JLYTableViewCell.h"
#import "JLYTableViewGlobals.h"

@interface ViewController () <JLYTableViewDelegate>

@end
```

## API
init JLYTableView

```objc
- (void)viewDidLoad {
[super viewDidLoad];

self.title = @"My AccountBook";
self.view.backgroundColor = [UIColor whiteColor];

CGFloat width = self.view.frame.size.width / 4;
NSArray *widths = @[@(width), @(width), @(width), @(width)];
NSString *plistFileName = @"dataSouce";
NSArray *actions = @[@"printDate:", @"printTotalAssets:", sNoAction, sNoAction];
NSArray *headerViewTitles = @[@"Date", @"TotalAssets", @"Profit&Loss", @"Rate"];
CGFloat headerViewHeight = 24.0;

JLYTableView *jlyTableView = [[JLYTableView alloc] initWithFrame:self.view.bounds
widths:widths
plistFile:plistFileName
actions:actions
headerViewTitles:headerViewTitles
headerViewHeight:headerViewHeight
delegate:self];
[self.view addSubview:jlyTableView];

}
```

## Actions
customize your own API for tap event of each cell

```objc
- (void)printDate:(UIButton *)sender
{
NSLog(@"%@",sender.currentTitle);
}

- (void)printTotalAssets:(UIButton *)sender
{
NSLog(@"%@",sender.currentTitle);
}

```



## JLYTableViewDelegate

```objc
@protocol JLYTableViewDelegate <NSObject>

@optional

// return height of row
- (CGFloat)tableViewCell:(JLYTableViewCell *)tableViewCell heightForRow:(NSInteger)row;

// return bgcolor of each cell
- (UIColor *)tableViewCell:(JLYTableViewCell *)tableViewCell colorOfColumn:(NSInteger)column inRow:(NSInteger)row;

// return text color of each cell
- (UIColor *)tableViewCell:(JLYTableViewCell *)tableViewCell contentColorOfColumn:(NSInteger)column inRow:(NSInteger)row;

//return border color
- (UIColor *)tableViewCellBorderColor:(JLYTableViewCell *)tableViewCell;

//return border width
- (CGFloat)tableViewCellBorderWidth:(JLYTableViewCell *)tableViewCell;

// return font of text
- (UIFont *)tableViewCell:(JLYTableViewCell *)tableViewCell fontOfColumn:(NSInteger)column;

//return border color
- (UIColor *)tableHeaderViewBorderColor:(JLYTableViewCell *)headerView;

//return border width
- (CGFloat)tableHeaderViewBorderWidth:(JLYTableViewCell *)headerView;

// return bgcolor of headerView cell
- (UIColor *)tableHeaderView:(JLYTableViewCell *)headerView colorOfColumn:(NSInteger)column;

// return text color of headerView cell
- (UIColor *)tableHeaderView:(JLYTableViewCell *)headerView contentColorOfColumn:(NSInteger)column;

// return font of headerView text
- (UIFont *)tableHeaderView:(JLYTableViewCell *)headerView fontOfColumn:(NSInteger)column;

// return alignment of headerView text
- (NSTextAlignment)tableHeaderViewAlignment:(JLYTableViewCell *)headerView;

@end
```

# Feedback

* GMail: jilingyu007@gmail.com


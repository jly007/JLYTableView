JLYTableView
============

* JLYTalbeView is a powerful implementation based on UITableView.
* It provides some interesting features, such as：multi-column display.
* Users can customize the tap event with each cell. 
* Special thanks to my friends. 

![image](https://github.com/jly007/JLYTableView/blob/master/ScreemShot/ScreemShot.png)

# Usage 
```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"My AccountBook";
    self.view.backgroundColor = [UIColor whiteColor];
    
    float width = self.view.frame.size.width / 4;
    NSArray *widths = @[@(width), @(width), @(width), @(width)];
    CGPoint startPoint = CGPointMake(0, 0);
    
    JLYTableView *jlyTableView = [[JLYTableView alloc] initWithFrame:self.view.bounds];
    [jlyTableView startWithWidths:widths
                       startPoint:startPoint
                        plistFile:@"datas"];
    
    NSArray *actions = @[sNoAction, @"printTotalAssets:", sNoAction, sNoAction];
    [jlyTableView setActions:actions WithTarget:self];
    
    NSArray *titles = @[@"Date", @"TotalAssets", @"Profit&Loss", @"Rate"];
    [jlyTableView setHeaderViewWithTitle:titles height:24];
    
    [self.view addSubview:jlyTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printDate:(UIButton *)sender
{
    NSLog(@"%@",sender.currentTitle);
}

- (void)printTotalAssets:(UIButton *)sender
{
    NSLog(@"%@",sender.currentTitle);
}


```




# Feedback

* GMail: jilingyu007@gmail.com


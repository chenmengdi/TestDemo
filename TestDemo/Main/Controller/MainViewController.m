//
//  MainViewController.m
//  TestDemo
//
//  Created by 陈孟迪 on 2017/10/12.
//  Copyright © 2017年 陈孟迪. All rights reserved.
//


#import "MainViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface MainViewController ()<UIWebViewDelegate>
{
    UIWebView *myWebView;
    NSMutableArray *sendDataArray;
    NSMutableArray *timeArray;
}
@end
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self loadChat];
}

- (void)createUI{

//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(scanBle)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
}


#pragma mark 加载图表
- (void)loadChat{

    myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)];
    myWebView.scalesPageToFit = YES;
    myWebView.delegate = self;
    [self.view addSubview:myWebView];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [myWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}
- (void)action{
//    [object object],[object object],[object object]
//    Fir Oct 20 2017 12:02:20 GMT+0800(CST)
    sendDataArray = [NSMutableArray array];
    
    for (int i = 0; i<9; i++) {
        int value = arc4random()%50;
        [sendDataArray addObject:@(500+value)];
    }
    NSLog(@"sendDataArray:%@",sendDataArray);
    
    NSString *setValueData = [NSString stringWithFormat:@"setValueData([%@])",[sendDataArray componentsJoinedByString:@","]];
    [myWebView stringByEvaluatingJavaScriptFromString:setValueData];
}
//开始加载请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    sendDataArray = [NSMutableArray array];
    timeArray = [NSMutableArray array];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(action) userInfo:nil repeats:YES];
}
- (NSString*)getNowTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}
@end

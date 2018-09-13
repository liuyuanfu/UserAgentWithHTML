//
//  ViewController.m
//  UserAgentWithHTML
//
//  Created by yuanFu·Liu on 2018/9/13.
//  Copyright © 2018年 com.weiYuan. All rights reserved.
//


#import "ViewController.h"
#import "AFNetworking.h"

#import "Ono.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self fixNoticeNet];
    
}
#pragma mark 访问网络 接口（固定数据）
-(void)fixNoticeNet{
    
    // 11111111111111111111111👇👇👇👇👇👇👇👇
    NSString *url = @"http://sh.58.com/ershoufang/35124211015627x.shtml?from=1-list-14&iuType=p_0&PGTID=0d30000c-0000-2696-f211-630768388da3&ClickID=1";
    
    NSString *stringPC     = @"User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36";
    NSString *stringClient = @"User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Mobile Safari/537.36";
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":stringClient}];
    // 2222222222222222222222222👇👇👇👇👇👇👇👇
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20)];
    //发请求
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
    webView.scalesPageToFit = YES;
    [webView loadRequest:req];
    [self.view addSubview:webView];
    
    NSString*userAgentString = [webView stringByEvaluatingJavaScriptFromString:
                                
                                @"navigator.userAgent"];
    
    NSLog(@"000000000000000useragent = %@",userAgentString);
    
    // 3333333333333333333333333👇👇👇👇👇👇👇👇
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
            
            NSLog(@"%@",[r allHeaderFields]);
        }
        NSError *error;
        // 将返回的data数据 转化成html格式的文本 （可用字符串接收）
        ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithData:responseObject error:&error];
        NSLog(@"2222222222222222222222document:%@",document);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


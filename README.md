iOS中强行设定UserAgent用AFNetworking请求拿到HTML
开始正题：（代码顺序1、2、3都放在一个方法里，其中2只负责测试参考，可以不添加）

1.指定链接、UserAgent和对UserAgent的存储更换！

// 要访问的链接

    NSString *url = @"http://sh.58.com/ershoufang/35124211015627x.shtml?from=1-list-14&iuType=p_0&PGTID=0d30000c-0000-2696-f211-630768388da3&ClickID=1";

// 任意找到的PC端UserAgent

    NSString *stringPC    =@"User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36";

//  任意找到的客户端UserAgentd

    NSString *stringClient = @"User-Agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Mobile Safari/537.36";

//  直接指定访问的UserAgent！很重要！很神奇！

    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":stringClient}];
2：用于测试，NSLog打印 查看UserAgent的替换是否正确！

// 简单的创建WebView

  UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20)];

    //发请求

    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];

    webView.scalesPageToFit=YES;

    [webViewloadRequest:req];

    [self.view addSubview:webView];

// 通过webView的方法获取UserAgent,指定的PC或客户端UserAgent不同答应的也不同

    NSString*userAgentString = [webView stringByEvaluatingJavaScriptFromString：@"navigator.userAgent"];

// 打印UserAgent

    NSLog(@"000000000000000useragent = %@",userAgentString);

NSLog查看打印的数据（若指定的事客户端）如：

000000000000000useragent = Mozilla/5.0 (iPhone; CPU iPhone OS 11_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15F79
3：重点来了，开始请求了！

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];

    [managerGET:urlparameters:nilprogress:nilsuccess:^(NSURLSessionDataTask*_Nonnulltask,id  _NullableresponseObject) {

        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {

            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;

            NSLog(@"%@",[rallHeaderFields]);

       }

        NSError*error;

（这里用的”ONOXMLDocument“通过cocoaPod在pod 'Ono', '~> 2.1.1',导入头文件#import "Ono.h"）

        // 将返回的data数据 转化成html格式的文本 （可用字符串接收）

        ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithData:responseObject error:&error];

        NSLog(@"2222222222222222222222document:%@",document);

    }failure:^(NSURLSessionDataTask*_Nullabletask,NSError*_Nonnullerror) {

        NSLog(@"%@",[error localizedDescription]);

    }];

// 最后将document 单做一个字符串 请求本公司后台的一个接口用作参数传给本公司后台！

NSLog查看打印的数据是：

2222222222222222222222document:HTML格式的数据！！！
可以说很详细了，这个知识点偏深冷，亲测可行！若有问题 留下联系方式，交流！

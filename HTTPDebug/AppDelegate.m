//
//  AppDelegate.m
//  HTTPDebug
//
//  Created by wanyc on 12/16/13.
//  Copyright (c) 2013 wanyc. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    [self getPOSTParams];
    
//    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://status.github.com/api/messages.json"]];
    
    
       NSString *JSONValue = @"{\"State\":\"true\",\"TotalScore\":\"3164\", \"AreaRanking\":\"9\", \"BrandRanking\":\"13\", \"TotalRanking\":\"281\",\"NoDealOrderCount\":\"22\", \"AlmostLostOrderCount\":\"0\",\"NoPriceCarCount\":\"0\", \"NoSmsPriceCarCount\":\"0\"}";
    
    NSData *jsonData = [JSONValue dataUsingEncoding:NSUTF8StringEncoding];
    
        NSDictionary *dc=  [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@---%@",[dc class],[dc  objectForKey:@"TotalScore"]);
    // Insert code here to initialize your application
}

//开始网络请求
- (IBAction)startRequest:(id)sender {
    NSString *urlString = [self.urlField stringValue];
    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    
    if(self.requestTypePop.selectedTag==POST){
        //POST请求
        
        //组装请求参数
        NSMutableDictionary *params = [self getPOSTParams];
        [httpClient postPath:[self.actionField stringValue] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self setResult:responseString];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:POST");
        }];
        
    }else{
        //GET请求
        [httpClient getPath:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self setResult:responseString];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ERROR:GET");
        }];
    }
}

//从返回值设置UI界面显示
- (void)setResult:(NSString *)response{
    [self.responseTextView setString:response];
    [[self.responseWebView mainFrame] loadHTMLString:response baseURL:nil];
}

//组装POST请求参数
- (NSMutableDictionary *)getPOSTParams{
    NSMutableDictionary *paramsDictionary = [NSMutableDictionary dictionary];
    NSView *paramView = [[self.tabView tabViewItemAtIndex:2] view];
    
    for (int i=100; i<106; i++) {
        
        NSTextField *paramField = (NSTextField *)[paramView viewWithTag:i];
        NSTextField *valueField = (NSTextField *)[paramView viewWithTag:i+100];
        
        NSString *paramString = [[paramField stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *valueString = [[valueField stringValue] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        //允许参数值为空，但是如果参数名为空的话，默认不添加这个参数到post请求中
        if (paramString.length>0) {
            [paramsDictionary setValue:valueString forKey:paramString];
        }
    }
    return paramsDictionary;
}
@end

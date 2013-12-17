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
    // Insert code here to initialize your application
}

- (IBAction)startRequest:(id)sender {
    NSString *urlString = [self.urlField stringValue];
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    if(self.requestTypePop.selectedTag==POST){
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [httpClient postPath:[self.actionField stringValue] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self setResult:responseString];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:POST");
        }];
        
    }else{
        [httpClient getPath:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self setResult:responseString];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ERROR:GET");
        }];
    }
}


- (void)setResult:(NSString *)response{
    [self.responseTextView setString:response];
    [[self.responseWebView mainFrame] loadHTMLString:response baseURL:nil];
}
@end

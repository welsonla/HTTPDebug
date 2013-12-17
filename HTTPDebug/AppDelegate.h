//
//  AppDelegate.h
//  HTTPDebug
//
//  Created by wanyc on 12/16/13.
//  Copyright (c) 2013 wanyc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AFNetworking.h"
#import <WebKit/WebKit.h>

typedef enum {
  GET=0,
  POST=1
}PostType;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *urlField;
@property (weak) IBOutlet NSPopUpButton *requestTypePop;
@property (weak) IBOutlet NSButton *runButton;

@property (weak) IBOutlet NSTextField *formIdField;
@property (weak) IBOutlet NSTextField *actionField;
@property (unsafe_unretained) IBOutlet NSTextView *responseTextView;
@property (weak) IBOutlet WebView *responseWebView;
@property (weak) IBOutlet NSTabView *tabView;



- (IBAction)startRequest:(id)sender;

- (NSMutableDictionary *)getPOSTParams;

- (void)setResult:(NSString *)response;

@end

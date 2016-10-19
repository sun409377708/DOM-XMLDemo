//
//  ViewController.m
//  GDataDOMDemo
//
//  Created by maoge on 16/10/19.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "ViewController.h"
#import <GDataXMLNode.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //https://raw.githubusercontent.com/sun409377708/DOM-XMLDemo/master/Practice.xml
    
    NSString *urlString = @"https://raw.githubusercontent.com/sun409377708/DOM-XMLDemo/master/Practice.xml";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //发起请求
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"请求错误 %@", error);
            return;
        }
        
        // 1. 创建文档(全部节点和内容)
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data error:NULL];
        
        for (GDataXMLElement *element in document.rootElement.children) {
//            NSLog(@"%@", element.children);
            
            for (GDataXMLNode *node in element.children) {
                NSLog(@"%@ -- %@", node.name, node.stringValue);
            }
        }
        
        
    }] resume];
}

@end

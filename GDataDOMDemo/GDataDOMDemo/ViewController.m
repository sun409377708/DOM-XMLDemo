//
//  ViewController.m
//  GDataDOMDemo
//
//  Created by maoge on 16/10/19.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "ViewController.h"
#import <GDataXMLNode.h>
#import "Video.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
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
            
            // 2. 创建模型
            Video *video = [[Video alloc] init];
            
            for (GDataXMLNode *node in element.children) {
                
                [video setValue:node.stringValue forKey:node.name];
            }
            
            for (GDataXMLNode *node in element.attributes) {
                [video setValue:node.stringValue forKey:node.name];
                [_dataArray addObject:video];
            }
            
        }
        NSLog(@"%@", _dataArray);
        
    }] resume];
    
}

@end

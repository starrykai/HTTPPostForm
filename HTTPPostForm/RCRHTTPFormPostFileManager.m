//
//  RCRHTTPFormPostFileManager.m
//  jinjin
//
//  Created by runnercoder on 15/12/11.
//  Copyright © 2015年 wukai. All rights reserved.
//
#import "RCRHTTPFormPostFileManager.h"

@implementation RCRHTTPFormPostFileManager

- (void)httpPostFormWithURLString:(NSString *)urlString filePath:(NSString *)filePath DataType:(NSString *)dataType {
  NSString *boundary = [[NSProcessInfo processInfo] globallyUniqueString];//分隔符
  NSString *fileName = [filePath lastPathComponent];// file name
  NSData *fileData = [NSData dataWithContentsOfFile:filePath];
  NSURL *httpURL = [NSURL URLWithString:urlString];
  
//  build body
  NSString *stringBodyBegin = [NSString stringWithFormat:@"--%@\n", boundary];//分割线必须单独一行
  NSString *stringBodyDisposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\" filename=\"%@\"\n", fileName];
  NSString *stringBodyContentType = [NSString stringWithFormat:@"Content-Type: %@\n\n", dataType];
  NSString *stringBodyEnd = [NSString stringWithFormat:@"\n--%@--", boundary];//结尾的分隔符加上--
  NSMutableData *httpBody = [NSMutableData data];
  [httpBody appendData:[stringBodyBegin dataUsingEncoding:NSUTF8StringEncoding]];
  [httpBody appendData:[stringBodyDisposition dataUsingEncoding:NSUTF8StringEncoding]];
  [httpBody appendData:[stringBodyContentType dataUsingEncoding:NSUTF8StringEncoding]];
  [httpBody appendData:fileData];
  [httpBody appendData:[stringBodyEnd dataUsingEncoding:NSUTF8StringEncoding]];
  
//  build request
  NSMutableURLRequest *httpRequest = [[NSMutableURLRequest alloc] init];
  [httpRequest setURL:httpURL];
  [httpRequest setHTTPMethod:@"POST"];
  [httpRequest setTimeoutInterval:60000];
  [httpRequest setValue:[NSString stringWithFormat:@"%@", @(httpBody.length)] forHTTPHeaderField:@"Content-Length"];
  [httpRequest setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];//指定编码方式和分隔符
  httpRequest.HTTPBody = httpBody;
  
//  发起请求
  NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
  [NSURLConnection sendAsynchronousRequest:httpRequest queue:operationQueue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
    if (connectionError) {
      
    } else {
      NSLog(@"%@", data);
    }
  }];
}

@end

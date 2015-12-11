//
//  RCRHTTPFormPostFileManager.h
//  jinjin
//
//  Created by runnercoder on 15/12/11.
//  Copyright © 2015年 wukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCRHTTPFormPostFileManager : NSObject
- (void)httpPostFormWithURLString:(NSString *)urlString filePath:(NSString *)filePath DataType:(NSString *)dataType;
@end

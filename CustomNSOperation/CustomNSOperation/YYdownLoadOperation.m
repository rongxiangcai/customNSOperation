//
//  YYdownLoadOperation.m
//  CustomNSOperation
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 JCKJ. All rights reserved.
//

#import "YYdownLoadOperation.h"

@implementation YYdownLoadOperation
- (void)main{
    NSURL *url=[NSURL URLWithString:self.url];
    NSData *data=[NSData dataWithContentsOfURL:url];
    UIImage *imgae=[UIImage imageWithData:data];
    if ([self.delegate respondsToSelector:@selector(downLoadOperation:didFishedDownLoad:)]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate downLoadOperation:self didFishedDownLoad:imgae];
        });
    }
    
}
@end

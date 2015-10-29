//
//  YYdownLoadOperation.h
//  CustomNSOperation
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 JCKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class YYdownLoadOperation;
@protocol YYdownLoadOperationDelegate <NSObject>

-(void)downLoadOperation:(YYdownLoadOperation*)operation didFishedDownLoad:(UIImage *)image;
@end

@interface YYdownLoadOperation : NSOperation
@property (nonatomic,copy) NSString *url;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) id<YYdownLoadOperationDelegate> delegate;
@end

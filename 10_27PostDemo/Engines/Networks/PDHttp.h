//
//  PDHttp.h
//  10_27PostDemo
//
//  Created by nate on 15/10/27.
//  Copyright (c) 2015年 nate. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PDHttpDelegate <NSObject>

-(void)PDHttpFinishedSuccessed:(NSDictionary*)aDicData;

-(void)PDHttpFinishedFailed:(NSDictionary*)aDicData;

@end

@interface PDHttp : NSObject

+(id)shareInstances;

@property(nonatomic, weak)id<PDHttpDelegate> delegate;

-(void)sendRequst:(NSString*)urlPath body:(NSString*)abody;

@end

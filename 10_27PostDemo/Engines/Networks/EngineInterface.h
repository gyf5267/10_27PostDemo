//
//  EngineInterface.h
//  10_27PostDemo
//
//  Created by nate on 15/10/27.
//  Copyright (c) 2015年 nate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EngineInterface : NSObject

+(id)shareInstances;

-(void)login:(NSString*)userName pwd:(NSString*)userPwd;
-(void)regist:(NSString*)userName pwd:(NSString*)userPwd;

@end

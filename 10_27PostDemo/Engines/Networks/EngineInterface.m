//
//  EngineInterface.m
//  10_27PostDemo
//
//  Created by nate on 15/10/27.
//  Copyright (c) 2015年 nate. All rights reserved.
//

#import "EngineInterface.h"
#import "PDHttp.h"

@interface EngineInterface ()<PDHttpDelegate>

@property(nonatomic, strong)PDHttp* pdHttp;

@end

@implementation EngineInterface

+(id)shareInstances{
    
    static EngineInterface* instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[EngineInterface alloc] init];
    });
    
    return instance;
}

-(PDHttp*)pdHttp{
    if (_pdHttp == nil) {
        _pdHttp = [[PDHttp alloc] init];
        
        _pdHttp.delegate = self;
    }
    return _pdHttp;
}

#pragma mark -PDHttpDelegate

-(void)PDHttpFinishedSuccessed:(NSDictionary*)aDicData{
    NSLog(@"Successed=%@",aDicData);
}

-(void)PDHttpFinishedFailed:(NSDictionary*)aDicData{
    NSLog(@"Failed=%@",aDicData);
}


-(void)login:(NSString*)userName pwd:(NSString*)userPwd{
    NSString* url = [NSString stringWithFormat:@"%@/verify.php",SERVER_IP];
    NSString* body = [NSString stringWithFormat:@"txtLoginName=%@&txtPassword=%@", userName, userPwd];
    
    [self.pdHttp sendRequst:url body:body];
}

-(void)regist:(NSString*)userName pwd:(NSString*)userPwd{
    NSString* url = [NSString stringWithFormat:@"%@/register.php",SERVER_IP];
    NSString* body = [NSString stringWithFormat:@"txtLoginName=%@&txtPassword=%@", userName, userPwd];
    
    [self.pdHttp sendRequst:url body:body];
}



@end

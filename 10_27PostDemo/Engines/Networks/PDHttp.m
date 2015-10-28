//
//  PDHttp.m
//  10_27PostDemo
//
//  Created by nate on 15/10/27.
//  Copyright (c) 2015年 nate. All rights reserved.
//

#import "PDHttp.h"

@interface PDHttp ()

@property(nonatomic, strong)NSMutableURLRequest* requst;

@end


@implementation PDHttp

#define RET_CODE 0

+(id)shareInstances{
    
    static PDHttp* instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[PDHttp alloc] init];
    });
    
    return instance;
}


-(id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

-(NSMutableURLRequest*)requst{
    if (_requst == nil) {
        _requst = [[NSMutableURLRequest alloc] init];
    }
    return _requst;
    
}
-(void)sendRequst:(NSString*)urlPath body:(NSString*)abody{
    
    NSURL* url = [NSURL URLWithString:[urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];//[[NSURL alloc] initWithString:urlPath ];
    
//    self.requst = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    [self.requst addObserver:self forKeyPath:@"timeoutInterval" options:NSKeyValueObservingOptionNew context:nil];
    
    NSData* data = [abody dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.requst setHTTPMethod:@"post"];
    [self.requst setHTTPBody:data];
    [self.requst setURL:url];
    [self.requst setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [self.requst setTimeoutInterval:10];
    
    NSOperationQueue* que = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:self.requst queue:que completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data && data.length>0 && connectionError == nil) {
            
            NSError* err = nil;
            
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            
            if (dic && [dic count]>0 && err == nil) {
                
                int ret = [[dic objectForKey:@"ret"] intValue];
                
                if (ret == RET_CODE) {
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(PDHttpFinishedSuccessed:)]) {
                        [_delegate PDHttpFinishedSuccessed:dic];
                    }
                }else{
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(PDHttpFinishedFailed:)]) {
                        [_delegate PDHttpFinishedFailed:dic];
                    }
                }
                
            }else{
                if (_delegate && [_delegate respondsToSelector:@selector(PDHttpFinishedFailed:)]) {
                    [_delegate PDHttpFinishedFailed:dic];
                }
            }
        }
        
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"timeoutInterval"]) {
        NSLog(@"123333");
    }
}

@end

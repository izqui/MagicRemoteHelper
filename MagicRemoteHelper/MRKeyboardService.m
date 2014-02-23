//
//  MRKeyboardService.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 20/01/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

#import "MRKeyboardService.h"
#import "MRApplescriptHelper.h"

@implementation MRKeyboardService

-(NSString *)serviceName{
    
    return @"Keyboard";
}
-(NSString *)appIdentifier{
    
    return @"com.apple.finder";
}
-(void)performAction:(NSString *)action callback:(void (^)())callback{
    
    
    NSString *name = [NSString stringWithFormat:@"keyboard-%@", action];
    [MRApplescriptHelper executeApplescriptWithName:name];
    if (callback) callback();
    
}
-(void)requestInfoWithCallback:(void (^)(NSDictionary *))callback{
    
    /*NSString *res = [MRApplescriptHelper executeApplescriptWithName:@"keyboard-info"];
    
    if (res && callback){
        
        callback(@{@"title":res});
    }*/
    callback(@{@"title":@"Keyboard", @"state":@"playing", @"service":[self serviceName]});
}

@end

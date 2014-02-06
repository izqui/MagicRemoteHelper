//
//  MRVLCService.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 20/01/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

#import "MRVLCService.h"
#import "MRApplescriptHelper.h"

@implementation MRVLCService

-(NSString *)serviceName{
    
    return @"VLC";
}
-(NSString *)appIdentifier{
    
    return @"org.videolan.vlc";
}

-(void)performAction:(NSString *)action callback:(void (^)())callback{
    
    
    NSString *name = [NSString stringWithFormat:@"vlc-%@", action];
    [MRApplescriptHelper executeApplescriptWithName:name];
    if (callback) callback();
    
}
-(void)requestInfoWithCallback:(void (^)(NSDictionary *))callback{
    
    NSString *res = [MRApplescriptHelper executeApplescriptWithName:@"vlc-info"];
    
    if (res){
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[res dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil]];
        NSInteger n = [dict[@"state"] integerValue];
        if (n > 0) dict[@"state"] = @"playing";
        else  dict[@"state"] = @"paused";
        
        NSLog(@"dict %@", dict);
        if (dict && callback) callback(dict);
    }
    
}


@end

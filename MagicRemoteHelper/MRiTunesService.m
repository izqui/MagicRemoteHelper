//
//  MRiTunesService.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 07/02/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

#import "MRiTunesService.h"
#import "MRApplescriptHelper.h"

@implementation MRiTunesService

-(NSString *)serviceName{
    
    return @"iTunes";
}
-(NSString *)appIdentifier{
    
    return @"com.apple.itunes";
}
-(void)performAction:(NSString *)action callback:(void (^)())callback{
    
    NSString *name = [NSString stringWithFormat:@"itunes-%@", action];
    [MRApplescriptHelper executeApplescriptWithName:name];
    if (callback) callback();
}
-(void)requestInfoWithCallback:(void (^)(NSDictionary *))callback{
    
    NSString *res = [MRApplescriptHelper executeApplescriptWithName:@"itunes-info"];
    if (res){
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[res dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (dict && callback) callback(dict);
    }
}
-(void)requestMediaCurrentImage:(void (^)(NSData *data, NSString *ext))callback{
    
    NSString *res = [MRApplescriptHelper executeApplescriptWithName:@"itunes-image"];
    if (res){
        
        NSData *d = [[NSFileManager defaultManager] contentsAtPath:res];
        
        if (d && callback) callback(d, [res pathExtension]);
        
    }
}

@end

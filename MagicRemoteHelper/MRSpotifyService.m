//
//  MRSpotifyService.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "MRSpotifyService.h"
#import "MRApplescriptHelper.h"

@implementation MRSpotifyService
-(NSString *)serviceName{
    
    return @"Spotify";
}
-(NSString *)appIdentifier{
    
    return @"com.spotify.client";
}
-(void)performAction:(NSString *)action callback:(void (^)())callback{
    
    NSString *name = [NSString stringWithFormat:@"spotify-%@", action];
    [MRApplescriptHelper executeApplescriptWithName:name];
    if (callback) callback();
}
-(void)requestInfoWithCallback:(void (^)(NSDictionary *))callback{
    
    NSString *res = [MRApplescriptHelper executeApplescriptWithName:@"spotify-info"];
    if (res){
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[res dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if (dict && callback) callback(dict);
    }
}
-(void)requestMediaCurrentImage:(void (^)(NSData *data))callback{
    
    NSString *res = [MRApplescriptHelper executeApplescriptWithName:@"spotify-image"];
    if (res){
        
        NSData *d = [[NSFileManager defaultManager] contentsAtPath:res];
        
        if (d && callback) callback(d);
        
    }
}
@end

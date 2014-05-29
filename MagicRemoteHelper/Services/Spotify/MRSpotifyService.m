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
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:[res dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil]];
        dict[@"service"] = [[self serviceName] lowercaseString];
        if (dict && callback) callback(dict);
    }
}
-(void)requestMediaCurrentImage:(void (^)(NSData *data, NSString *ext))callback{
    
    NSString *res = [MRApplescriptHelper executeApplescriptWithName:@"spotify-image"];
    if (res){
        
        NSData *d = [[NSFileManager defaultManager] contentsAtPath:res];
        
        if (d && callback) callback(d, [res pathExtension]);
        
    }
}
@end

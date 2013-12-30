//
//  MRSpotifyService.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "MRSpotifyService.h"

@implementation MRSpotifyService
-(NSString *)serviceName{
    
    return @"Spotify";
}
-(void)performAction:(NSString *)action callback:(void (^)())callback{
    
    NSString *name = [NSString stringWithFormat:@"spotify-%@", action];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *str = [bundle pathForResource:name ofType:@"applescript"];
    NSLog(@"path %@", str);
    NSURL *url = [[NSURL alloc] initFileURLWithPath:str];
    NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:url error:nil];
    NSAppleEventDescriptor *event = [script executeAndReturnError:nil];
    if (callback) callback();
}
@end

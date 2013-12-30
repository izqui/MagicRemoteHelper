//
//  AppDelegate.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "AppDelegate.h"
#import "MRServer.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[MRServer sharedServer] setAcceptedActions:@[@"playpause",@"next", @"prev"]];
    [[MRServer sharedServer] setConnectionBlock:^(NSString *host){
        
        NSLog(@"Host connected %@", host);
    }];
    [[MRServer sharedServer] setActionBlock:^(NSString *action){
        
        NSLog(@"Perform action %@", action);
    }];
    [[MRServer sharedServer] startServer];
}

@end

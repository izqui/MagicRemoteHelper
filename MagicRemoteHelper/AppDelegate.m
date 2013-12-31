//
//  AppDelegate.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "AppDelegate.h"
#import "MRServer.h"
#import "MRServicesManager.h"
#import "MRSpotifyService.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[MRServicesManager sharedManager] addService:[[MRSpotifyService alloc] init]];
   
    
    [[MRServer sharedServer] setAcceptedActions:@[@"playpause",@"next", @"prev"]];
    [[MRServer sharedServer] setConnectionBlock:^(NSString *host){
        
        //host = @"http://localhost:3004";
        
        [[MRServer sharedServer] setClientHost:host];
        
        [self sendCurrentInfo];
        
    }];
    [[MRServer sharedServer] setActionBlock:^(NSString *action){
        
        [[MRServicesManager sharedManager] makeAction:action callback:^{
            [self sendCurrentInfo];
        }];
    }];
    [[MRServer sharedServer] startServer];
}

-(void)sendCurrentInfo{
    
    [[MRServicesManager sharedManager] infoRequestWithCallback:^(NSDictionary *info) {
       
    }];
}
@end

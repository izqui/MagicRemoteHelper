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
#import "MRKeyboardService.h"
#import "MRVLCService.h"
#import "MRStatusView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[MRServicesManager sharedManager] addService:[[MRSpotifyService alloc] init]];
    [[MRServicesManager sharedManager] addService:[[MRVLCService alloc] init]];
    [[MRServicesManager sharedManager] addService:[[MRKeyboardService alloc] init]];
    
    
    [[MRServicesManager sharedManager] setSelectedServiceIndex:0];
    
    
    [[MRServer sharedServer] setAcceptedActions:@[@"playpause",@"next", @"prev"]];
    [[MRServer sharedServer] setConnectionBlock:^(NSString *host){
    
        //host = @"http://localhost:3004";
        
        [[MRServer sharedServer] setClientHost:host];
        
    }];
    [[MRServer sharedServer] setActionBlock:^(NSString *action){
        
        [[MRServicesManager sharedManager] makeAction:action callback:^{
            
        }];
    }];
    //[[MRServer sharedServer] startServer];
    
    menu = [[MRMenu alloc] init];
    
    [self setStatusItem];
}

-(void)setStatusItem{
    
    if (!statusItem) statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    
    statusItem.highlightMode = YES;
    
    statusItem.menu = menu;
    statusItem.action = @selector(menuWillOpen:);
    
    MRStatusView *v = [[MRStatusView alloc] initWithFrame:CGRectMake(0, 0, 24, 20) menu:menu statusItem:statusItem];
    statusItem.view = v;
    
}

-(void)menuWillOpen:(NSMenu *)menu{
    
}
@end

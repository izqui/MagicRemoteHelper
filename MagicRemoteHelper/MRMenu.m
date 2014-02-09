//
//  MRMenu.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 27/01/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

#import "MRMenu.h"
#import "LaunchAtLoginController.h"
#import <Sparkle/Sparkle.h>

@implementation MRMenu

- (id)init{
    
    if (self = [super initWithTitle:@"MagicRemote"]){
        
        [self setMenu];
    }
    
    return self;
}
- (void)setMenu{
    
    [self removeAllItems];
    
    //Current IP
    NSMenuItem *ip = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Host: %@", [[NSHost currentHost] addresses][1]] action:nil keyEquivalent:@""];
    [ip setEnabled:NO];
    ip.tag = 0;
    [self addItem:ip];
    
    //Launch on startup
    NSMenuItem *su = [[NSMenuItem alloc] initWithTitle:@"Launch on startup" action:nil keyEquivalent:@""];
    [su setState:([[[LaunchAtLoginController alloc] init] launchAtLogin]) ? NSOnState : NSOffState];
    su.tag = 1;
    [self addItem:su];
    
    //Hola quiero updatear
    
    
    NSMenuItem *uu = [[NSMenuItem alloc] initWithTitle:@"Check update..." action:nil keyEquivalent:@""];
    uu.tag = 3;
    [self addItem:uu];

    //Quit
    
    NSMenuItem *qu = [[NSMenuItem alloc] initWithTitle:@"Quit" action:nil keyEquivalent:@""];
    qu.tag = 2;
    [self addItem:qu];
    
    uu.target = su.target = qu.target = self;
    uu.action = su.action = qu.action = @selector(menuClick:);
}

- (void)menuClick:(NSMenuItem *)sender{
    
    switch (sender.tag) {
        case 1:
            [self startup];
            break;
        case 2:
            [self quit];
        case 3:
            [[SUUpdater sharedUpdater] checkForUpdates:nil];
        default:
            break;
    }
}

- (void)startup{
    
    /*[[NSUserDefaults standardUserDefaults] setBool:![[NSUserDefaults standardUserDefaults] boolForKey:@"start"] forKey:@"start"];
    [[NSUserDefaults standardUserDefaults] synchronize];*/
    LaunchAtLoginController *l = [[LaunchAtLoginController alloc] init];
    [l setLaunchAtLogin:![l launchAtLogin]];
    [self setMenu];
}
- (void)quit{
    
    [NSApp terminate:self];
}
@end

//
//  AppDelegate.h
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MRMenu.h"
#import <Sparkle/Sparkle.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSStatusItem *statusItem;
    MRMenu *menu;
    
}

@end

//
//  MRStatusView.h
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 27/01/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MRStatusView : NSView <NSMenuDelegate>
{
    
    NSMenu *menu;
    NSStatusItem *statusItem;
    BOOL highlight;
}

- (id)initWithFrame:(NSRect)frame menu:(NSMenu *)m statusItem:(NSStatusItem *)s;
@end

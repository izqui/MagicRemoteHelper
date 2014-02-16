//
//  MRStatusView.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 27/01/14.
//  Copyright (c) 2014 Jorge Izquierdo. All rights reserved.
//

#import "MRStatusView.h"

@implementation MRStatusView

- (id)initWithFrame:(NSRect)frame menu:(NSMenu *)m statusItem:(NSStatusItem *)s
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self registerForDraggedTypes:[NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
        menu = m;
        statusItem = s;
        

    }
    
    return self;
}


- (void)setMenu:(NSMenu *)_menu {
    [_menu setDelegate:self];
    [super setMenu:_menu];
}

- (void)mouseDown:(NSEvent *)event {
    [statusItem popUpStatusItemMenu:menu]; // or another method that returns a menu
}

- (void)menuWillOpen:(NSMenu *)menu {
    highlight = YES;
    [self setNeedsDisplay:YES];
}

- (void)menuDidClose:(NSMenu *)menu {
    highlight = NO;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect {
    
    NSRect bounds = [self bounds];
    [statusItem drawStatusBarBackgroundInRect:bounds withHighlight:highlight];
    [[NSImage imageNamed:@"statusicon"] drawInRect:CGRectMake(5, 1, 20, 20) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
    
    
    [super drawRect:rect];
}


@end

//
//  MRServer.h
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Barista/Barista.h>
#import <Barista/BARRouter.h>
#import <Barista/BARBodyParser.h>

typedef void (^ConnectionBlock)(NSString *host);
typedef void (^ActionBlock)(NSString *action);

@interface MRServer : NSObject
{
    BARServer *server;
    BOOL up;
}
+(id)sharedServer;
-(void)startServer;
-(void)stopServer;

@property (nonatomic) NSInteger port;
@property (nonatomic, copy) ConnectionBlock connectionBlock;
@property (nonatomic, copy) ActionBlock actionBlock;
@property (nonatomic, strong) NSArray *acceptedActions;

@end

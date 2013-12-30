//
//  MRServer.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "MRServer.h"


@implementation MRServer

- (id)init{
    
    if (self = [super init]){
        _port = 3003;
        up = false;
        _acceptedActions = @[];
    }
    return self;
}
+ (id)sharedServer{
    
    static MRServer *sharedServer = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedServer = [[self alloc] init];
    });
    
    return sharedServer;
}

-(void)startServer{
    
    if (!up){
        
        server = [self createServer];
        
        server.listening = up = YES;
        
    }
}

-(void)stopServer{
    
    if (up){
        
        server.listening = up = NO;
    }
}
-(BARServer *)createServer{
    
    BARServer *srv = [BARServer serverWithPort:self.port];
    
    BARRouter *router = [[BARRouter alloc] init];
    [srv addGlobalMiddleware:[[BARBodyParser alloc] init]];
    
    [srv addGlobalMiddleware:router];
    
    [router addRoute:@"/" forHTTPMethod:@"GET" handler:^BOOL(BARConnection *connection, BARRequest *request, NSDictionary *parameters) {
        
        NSString *ip = parameters[@"ip"];
        
        BARResponse *response = [[BARResponse alloc] init];
        response.statusCode = 200;
        
        NSMutableDictionary *body = [NSMutableDictionary dictionaryWithDictionary:@{@"name": [[NSHost currentHost] localizedName]}];
        if (ip) body[@"ip"] = ip;
        
        response.body = body;
        
        if (ip && _connectionBlock) _connectionBlock(ip);
        
        [connection sendResponse:response];
        return YES;
    }];
    
    [router addRoute:@"/action/:action" forHTTPMethod:@"GET" handler:^BOOL(BARConnection *connection, BARRequest *request, NSDictionary *parameters) {
        
        NSString *action = parameters[@"action"];
        
        BARResponse *response = [[BARResponse alloc] init];
        
        if ([self isActionAccepted:action]){
            
            response.statusCode = 200;
            response.body = @{@"status": @"ok"};
            if (_actionBlock) _actionBlock(action);
        }
        else {
            
            response.statusCode = 404;
            response.body = @{@"status": @"not found action"};
        }
        
        [connection sendResponse:response];
        return YES;
    }];
    
    return srv;
}

-(BOOL) isActionAccepted:(NSString *)action{
    
    for (NSString *s in _acceptedActions){
        
        if ([s isEqualToString:action]) return YES;
    }
    return NO;
}
@end

//
//  MRServicesManager.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "MRServicesManager.h"

@implementation MRServicesManager
+ (id)sharedManager{
    
    static MRServicesManager *s = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        s = [[self alloc] init];
    });
    
    return s;
}

-(id) init{
    
    if (self = [super init]){
        
        _selectedServiceIndex = 0;
        services = @[];
    }
    return self;
}

- (void)setSelectedServiceIndex:(NSInteger)selectedServiceIndex{
    
    if (services.count < selectedServiceIndex){
        
        _selectedServiceIndex = selectedServiceIndex;
        selectedService = services[selectedServiceIndex];
    }
}
- (void)addService:(id<MRService>)service{
    
    NSMutableArray *a = [NSMutableArray arrayWithArray:services];
    [a addObject:service];
    
    services = a;
    
    if (!selectedService) {
        
        selectedService = service;
        _selectedServiceIndex = 0; //Already set to 0, just to clarify
    }
}

-(void) makeAction:(NSString *)action callback:(void (^)())callback{
    
    if (selectedService && [selectedService respondsToSelector:@selector(performAction:callback:)]){
        
        [selectedService performAction:action callback:callback];
    }
    else {
        
        NSLog(@"No services bro");
    }
}
-(void) infoRequestWithCallback:(void (^)(NSDictionary *dict))callback{
    
    if (selectedService && [selectedService respondsToSelector:@selector(requestInfoWithCallback:)]){
        
        [selectedService requestInfoWithCallback:callback];
    }
    else {
        
        NSLog(@"No services bro");
    }
}
-(void) getImageWithCallback:(void (^)(NSData *data))callback{
    
    if (selectedService && [selectedService respondsToSelector:@selector(requestMediaCurrentImage:)]){
        
        [selectedService requestMediaCurrentImage:callback];
    }
    else {
        
        callback(nil);
    }
}
@end

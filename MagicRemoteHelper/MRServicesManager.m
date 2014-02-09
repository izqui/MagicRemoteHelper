//
//  MRServicesManager.m
//  MagicRemoteHelper
//
//  Created by Jorge Izquierdo on 30/12/13.
//  Copyright (c) 2013 Jorge Izquierdo. All rights reserved.
//

#import "MRServicesManager.h"
#import "MRApplescriptHelper.h"

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
    
    if (services.count > selectedServiceIndex){
        
        _selectedServiceIndex = selectedServiceIndex;
        selectedService = services[selectedServiceIndex];
        
        NSLog(@"Selected: %@", [selectedService serviceName]);
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

- (NSArray *)getServices{
    
    NSMutableArray *retArr = [NSMutableArray array];
    NSArray *ss = services;
    
    for (int i = 0; i<ss.count; i++){
        
        NSObject<MRService> *s = ss[i];
        
        if ([MRApplescriptHelper isAppInstalled:[s appIdentifier]]){
            
            [retArr addObject:@{@"name":s.serviceName, @"id":[NSNumber numberWithInt:i], @"selected":[NSNumber numberWithBool:([[MRServicesManager sharedManager] selectedServiceIndex] == i)], @"hasArtwork":[NSNumber numberWithBool:[s respondsToSelector:@selector(requestMediaCurrentImage:)]]}];
        }
    }

    return retArr;
}

//CONVENIENCE METHODS
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
-(void) getImageWithCallback:(void (^)(NSData *data, NSString *ext))callback{
    
    if (selectedService && [selectedService respondsToSelector:@selector(requestMediaCurrentImage:)]){
        
        [selectedService requestMediaCurrentImage:callback];
    }
    else {
        
        callback(nil, nil);
    }
}
@end

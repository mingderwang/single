//
//  MDBlueToothCenter.m
//  single
//
//  Created by Ming-der Wang on 11/16/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import "MDBlueToothCenter.h"

@implementation MDBlueToothCenter
static MDBlueToothCenter *instance = nil;

#pragma mark - singleton

// a singleton
+ (MDBlueToothCenter *)getDefaultInstance{
    @synchronized(self) {
        if (instance == nil){
            instance = [[MDBlueToothCenter alloc] init];
        }
    }
    return instance;
}
- (id)init
{
    if ((self = [super init]))
    {
        self.dicoveredPeripherals = [NSMutableArray new];
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    
    return self;
}


-(void) startScan {
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:TRUE], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
    
    [manager scanForPeripheralsWithServices:self.dicoveredPeripherals options:options];
}

-(void) stopScan {
    [manager stopScan];
}

#pragma mark - CBCentralManagerDelegate

/*!
 *  @method centralManagerDidUpdateState:
 *
 *  @param central  The central manager whose state has changed.
 *
 *  @discussion     Invoked whenever the central manager's state has been updated. Commands should only be issued when the state is
 *                  <code>CBCentralManagerStatePoweredOn</code>. A state below <code>CBCentralManagerStatePoweredOn</code>
 *                  implies that scanning has stopped and any connected peripherals have been disconnected. If the state moves below
 *                  <code>CBCentralManagerStatePoweredOff</code>, all <code>CBPeripheral</code> objects obtained from this central
 *                  manager become invalid and must be retrieved or discovered again.
 *
 *  @see            state
 *
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if (![self supportBLE])
    {
        @throw ([NSError errorWithDomain:@"Bluetooth LE is not supported on this device."
                                    code:404
                                userInfo:nil]);
    }
}

- (BOOL) supportBLE {
    switch ([manager state])
    {
        case CBCentralManagerStatePoweredOn:
            return TRUE;
        default:
            return FALSE;
    }

}

@end

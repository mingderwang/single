//
//  MDBlueToothCenter.h
//  single
//
//  Created by Ming-der Wang on 11/16/13.
//  Copyright (c) 2013 Kat Digital Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface MDBlueToothCenter : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate> {
    id delegate;
    CBCentralManager *manager;
    CBPeripheral *firstPeripheral;
    BOOL supportBLE;
    BOOL isScanning;
}

@property (nonatomic, strong) NSMutableArray *dicoveredPeripherals;

+ (MDBlueToothCenter *)getDefaultInstance;
-(void) startScan;
-(void) stopScan;

@end
